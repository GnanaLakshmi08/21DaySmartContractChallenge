//Create a freelancer.com with Freelancer, Project and Organisation entities
pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract FreelancerDotCom {
    struct Freelancer {
        uint id;
        address payable freelancerAddr;
        string skills;
        uint num_experience;
    }
    
    Freelancer[] freelancers;
    address payable[] freelancer_addr;
    mapping(address => Freelancer) freelancerMap;
    
     struct Org{
        uint orgId;
        address payable orgAddr;
    }
    
    struct Project{
        uint projectId;
        uint orgId;
        string skillsReq;
        uint num_experience;
        uint cost;
        bool allocated;
        
    }
    
    Org[] orgs;
    Project[] projects;
    
    address payable[] org_addr;
    mapping(address => Org) orgMap;
    
    function registerFreelancer(address payable _address, uint _id, string memory _skills, uint _num_experience) public {
        Freelancer memory freelancer;
        freelancer.id = _id;
        freelancer.freelancerAddr = _address;
        freelancer.skills = _skills;
        freelancer.num_experience = _num_experience;
        
        freelancerMap[_address] = freelancer;
        freelancers.push(freelancer);
        
    }
    
    function registerOrg(address payable _address, uint _orgId) public {
        Org memory org;
        org.orgAddr = _address;
        org.orgId = _orgId;
    
        orgMap[_address] = org;
        orgs.push(org);
    }
    
    function registerProject(uint _projectId, uint _orgId, string memory _skillsReq, uint _numExperience, uint _cost) public returns( Project memory) {
        Project memory project;
        project.projectId = _projectId;
        project.orgId = _orgId;
        project.skillsReq = _skillsReq;
        project.num_experience = _numExperience;
        project.cost = _cost;
        projects.push(project);
        
        return project;
    }
    
    event matchedProject(address freelancer, uint cost, bool allocated);
    
    function allocateProjects(uint _projectId, uint _orgId, string memory _skillsReq, uint _numExperience, uint _cost) public {
        Project memory project = registerProject(_projectId, _orgId, _skillsReq, _numExperience, _cost);
        uint length = freelancer_addr.length;
        address payable assignedFreelancer;
        uint param = 0;
        for(uint i = 0; i < length; i++){
            Freelancer memory freelancer = freelancerMap[freelancer_addr[i]];
            if(compareStrings(freelancer.skills,_skillsReq) && (freelancer.num_experience >= _numExperience)){
                param += 1;
                assignedFreelancer = freelancer_addr[i];
                break;
            }
        }
        if (param == 1){
            project.allocated = true;
            assignedFreelancer.transfer(_cost);
            emit matchedProject(assignedFreelancer, _cost, project.allocated);
            
        }
        else{
            project.allocated = false;
            emit matchedProject(assignedFreelancer, _cost, project.allocated);
        }
            
    }
    
    function compareStrings (string memory a, string memory b) public pure
       returns (bool) {
            return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );

       }
}
