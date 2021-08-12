## AWS Native Service를 활용한 고가용성 웹 서비스 구축

![아키텍처_최종_수정-3-Tier Service + Backup + CI_CD + EKS](https://user-images.githubusercontent.com/49023663/129140085-b6ddaf95-85f1-4e31-a367-b9c64c08db31.png)

<br>

---

<br>

| 구분 | AWS 서비스 | 내용 |
| :---: | :---: | :--- |
| 고가용성 및 내결함성 | VPC <br> ELB <br> RDS <br> | 2개의 Availability Zone 사용 <br> 외부로부터 오는 부하를 분산 <br> Multi-AZ 구조로 DB 설치 |
| 확장성 | Auto Scaling <br> EKS | Health Check를 통해 확장을 자동화 <br> 컨테이너 단위로 WAS 서버를 배포 |
| 보안성 | Route53 <br> NAT Gateway <br> WAF <br> GuardDuty | SSL 인증을 통해 접근 <br> 서버와 DB는 NAT를 통해서만 외부와 통신 <br> 웹 공격으로부터 리소스를 보호 <br> 잠재적인 보안 위협 요소를 탐지 |
| 효율적인 운영 | CloudWatch <br> CloudTrail <br> S3 <br> Backup <br> Code Series | 서버의 로그를 수집 <br> AWS 계정의 활동 감시 및 추적 <br> 서비스의 로그와 아티팩트를 저장 <br> 서버와 DB를 백업 <br> CI/CD 파이프라인을 자동화 |
