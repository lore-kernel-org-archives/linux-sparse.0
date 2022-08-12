Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4645CC00140
	for <linux-sparse@archiver.kernel.org>; Fri, 12 Aug 2022 09:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiHLJsl (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 12 Aug 2022 05:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHLJsk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 Aug 2022 05:48:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50995AA4C6
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2022 02:48:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C9fOpv002110
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2022 09:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=phI5dQobNwOUIijqHTtNyZhNKBnF3lXzdPuIT6wglHo=;
 b=iDQT6Rjzho3gfKvAgilS+VfdTffnW7yd/v9T86DlZLDLRiZf6oPcJ+zg/7cBRNV18rTB
 8hlzVlTUgDCsYDEsJBQGUP8Chwx6edY+P4HgJ6sva5Qe0zv13AJdDe3q2YTiQ4cePO0x
 l/WIt5y8wjl8xd19fy8n/QjgS+SsZOy4+McTWkqft8GgrwnxCUu5xEkpQVNoJW4IJhaE
 zp62ZiQ8TuONPNEekkonFXtyNkiK2xiAT4BsLvqoao2L06A9YAt5J5nhmjw1LUfl90i+
 fLahuOntsoC31CZCeUPY/uauo8CSotOiJkRrYm/yO57/BEWIKfac0YT1uGSmcTWyo3vJ lQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdy2r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2022 09:48:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C87K3G020549
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2022 09:48:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqkgnhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2022 09:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3NLLjyWWLOMzs4plGDoLFhghffG6vT1mCnwRECkUm66UnquP3qLPvNo2r9EGYhZPQv8n3/NmYS57IUJSs3Jjt8/1Xnwsr/XjJzNsM/06AaeJuIl+OZmDnoydPjr10mSwpuCtKKwtf1uFVPvGhm9DhONmeTZjpVPrEQ8qxCnabl78yNqMbP91L8oOoH6rJKtN6SPBxqHGi6sD+RcvivRz7VUQHx50N0rlSB4oCLiVUJWBKqeodNTEmlboO2fr4JlO5/bpR/9CD149DhuClN4/Vab9M1gY/HCijli4BeVl+Oz8GFMrp5cyINFwrEnxEgIqkDQxQPkMD/+HaN1mlccdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phI5dQobNwOUIijqHTtNyZhNKBnF3lXzdPuIT6wglHo=;
 b=eQji/mPLjszgnPPSUPArvyKogzCYKfzuurCqlX3l53+igqVl5rWlL3W6U6tHcaiaN1aAt2B1NDMYwrYa3ALRgyg9BGkJ+9BcT3eRT5iKX8kDnSX+AvKgAUc0iuLpePE1h/eWcDLiUQTl01GATNm4Y//qPt+Fd9Kif3oT4RZUgH8q40wJS1oFbRIo6w8XVS6ORKuy79e8n6lscVmd4xTKkIyt+1HZplONDfN9AHKX+/V6gGPO749+y6WizjLi2Ajr4JxEg1xgmxf/r3WqrPmYXfZtlpIilkftv+NSgyb1iN/zYTGIqDRR41pa9zdBVJaiL74SPNPvvrpwEdA6yaIARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phI5dQobNwOUIijqHTtNyZhNKBnF3lXzdPuIT6wglHo=;
 b=K+2D2o3fbpbw3SjY1XQO9tn6/Zke+iQEw+UYvy7/d80nr5ChMgBfmhl34QLapboMrEmMWVSlsL8Dlfw0oroNFV2yAt+cwpZcj5UIftscSPNBveWhvKCqcUHRYypwDAWkpUSEP8psn0HGUry8H6WLuEOYSwzgR+EA9tsHohYTEQw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1490.namprd10.prod.outlook.com
 (2603:10b6:404:45::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 09:48:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.024; Fri, 12 Aug 2022
 09:48:35 +0000
Date:   Fri, 12 Aug 2022 12:48:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linux-sparse@vger.kernel.org
Subject: handling C99 declarations after a case statement
Message-ID: <20220812094826.GL3438@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0142.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2194eea-ad79-49c5-0bc8-08da7c47d340
X-MS-TrafficTypeDiagnostic: BN6PR10MB1490:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1DMeWkWoB5Kq8BExjNwKtxRkmWuSpKfoeGj1ajazg41uFbBgptRxN9+Cx2ezk2+OV0gJDJr7EJJkuO/To9Tviihr6n/N2tqNmCRh2kB0aEONzuwpmviKyH16uC5Jgf5mS82icQDSYQVua8lritIVwRrpGVgcDRmkAz55DMF1+GQyXWodaYnqAkVMeBRvBLEa4cqVhHHMgYMb4R4QNbBwvjVDVS52hxUcwmVx+G8X5bqUNQ44xoGwI0M3Hj5UJpfjlQXcZa0qhuPJxqcMzEHsiz1ezB9STgbm/+RliK4RxZka7DutdBjtUdNsplOU413J3iMYk6Ec4rAwq5sikXCgPXg5vEk7oMRIYpfUMJpYUxhkI3sXyWBNPbxh+1L/MXGFuIKM5Uza8If7jYBYkZoREUNj3t4nYavuobTyPci6/Mn7ZWjBuKBSK8wD9ZNkLiy6pTbzhrmQqgr1nJgI58i5y/7I72fIadbs2v4eIXkdpL/s/TSrQWl3bMfup/15BrczBw/PVwJI2a/nX7gEf/eAzsPbK9taCGgga9vQhnu+pkYFx0DTL5ggUI1aes7BFnsAiNn7vh93qQB3p3lw73c+GsNX6y0Bw1mpT7e8J6gDsGgzcnPi1T8JUlW2Okf3IqC3rh+pywSUMM4ZCxZgAPzcxj/Fd2iKizU+u/TfWg9Hd0n/l+zjr/tGpj3WIIgkshPaDt1sZwHy1Qy8+e9Qhh+c/BFP4DXFcTis0lXaipB2TnUIzYRG9qd4drd/cdkubtD5TK4k3s6IuQppSt+EnmdZPxq77q3D3yVjipsrgEFPq8SPWip18ZaKw0ye9twT8BQCDkmBzTs1TFqiaFEVdKfhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(66476007)(26005)(9686003)(6512007)(38350700002)(38100700002)(966005)(4744005)(44832011)(6486002)(52116002)(8936002)(86362001)(478600001)(5660300002)(6506007)(33656002)(83380400001)(6666004)(41300700001)(8676002)(2906002)(66946007)(6916009)(66556008)(186003)(1076003)(33716001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pozpMOeXMbvqN3V8p4+6P4qlOJNmk4oLCVLCFPCF4PuEMgckD6z+mQyI5lvY?=
 =?us-ascii?Q?I4AtL5esDfqqLDkcjXylA/mo3dg2La4hvkXWAcSXPAK6YaQuE0WPX1vPuA6H?=
 =?us-ascii?Q?SwR0jVuhPUeKk8v1lnPecBVvoOeGUyY4aG5D36yVK/cKlVqCT9ekk6O1ATV0?=
 =?us-ascii?Q?cE5GaIVRWTKXbJRX6VYuWARpo+CHRJ8mEb5LFMSiNSx1fRT93RfmyOhexCPf?=
 =?us-ascii?Q?iSIVE+rhsILYoABKe7VwhNS+1XJqs6H5IR0PaXhgMjmExG8ti0QsEPVKcfQT?=
 =?us-ascii?Q?SRVRcLlFVWphi11mQhDd1DkGvDgejgcl/n+P0ZX1GmR/8OPlM1Kc2ESEECNS?=
 =?us-ascii?Q?cER3GLDUDGaiOSZMSf2zgICbZFfUJe6qqLNWY/DDnxsd1lyqlK+HTXbbf5b0?=
 =?us-ascii?Q?RWPYZPmKLmEYuqJNJI7vQH7ONWo66nfSdAgVgklS+lOBgmkQCiyGXFobNCRq?=
 =?us-ascii?Q?wsQIEZT9EF05jKsnSSUZsVcZt8zqCEhRxlCt+9VCcGCNXsqtTwRLgWL2X5PD?=
 =?us-ascii?Q?lWa5OAshFMlW44Bxte1lgz3URBSIyhSLjIVOiRZTfLVEDoQR1/ZVXgbM3uc6?=
 =?us-ascii?Q?vUo2jITOPOVhF2rv+OvYBJpnB6UDtCWyeTrX0QrXkbMd2Hx41DC6NAzZ78r+?=
 =?us-ascii?Q?TDOCqQW8rQHi+mddrwonmiQtfCC5buOLvBXk/Nkq9WyajeboH0XbEN2BE8Fo?=
 =?us-ascii?Q?9p2/TKuzGRle3jmmuAUOYpb7aoS/RLjehy2HO7C6WHugjw07Xe4AahllxEHZ?=
 =?us-ascii?Q?x98KsZ084I4ne7NX5V8X700B1iCOobBdYMCdIs52dyjFgLXbg9iCnmAg+Au5?=
 =?us-ascii?Q?+bmEbEtJ7pZD/GIV01ChM4EgoHWfDhfVPLz69miY4K+YssaufAbvXkHM21MB?=
 =?us-ascii?Q?+pkJgsomHfEnYnsKPfFtHfxY9I//rSiQ9BGc+z/Q12UWqixCwlktM7ZLOj8i?=
 =?us-ascii?Q?x/9mmTAeD3xsvY2vdF7qLtvlB5NT5Mvqg0Q7sPPY12CLhg/VCst36qUJ2pMn?=
 =?us-ascii?Q?JiJhzl5UY01qE+4CtRWRZjhhyMbvorJi2+9OhUK+mJc9VVASAFYT/ZlDHKx0?=
 =?us-ascii?Q?WWnoPEOo4QiTiE9oMrDt7k54U0NA/RPsCi3nVOkerNoROUkAiova2Z8lzGGG?=
 =?us-ascii?Q?IineOBvJWXMc1o5EhGe0Utk6q3fmP/Zs43uYxlTP8xHSmj360a16SmqDDqX1?=
 =?us-ascii?Q?QejW+/FYVOWAJ6XfQhOhHfTtGm+P3g/J8BDOonwjAVJdvAxfxjZaJG0fG/mY?=
 =?us-ascii?Q?t2UIOB7NasNnX6km1/3038mM7T1aY26gY0JzRnE1xXxvf59DHTNusT4nUjds?=
 =?us-ascii?Q?0aSzKSvfT7Wywy0dhq/k3L5nPy+soQJ7pj6XUkv6vRwmN5KDU+5t9b2SxWKs?=
 =?us-ascii?Q?vhBDalyNCXOSkV71cwqKZCmMq8H+PhXaNNvvAq2KV7eige8JijdpECDZLA8/?=
 =?us-ascii?Q?JCuqOlsrzlWWbXAWaSCwDuxRni5gpppBz0yYyDpA2wPErIRX3MzDRO5dSvZI?=
 =?us-ascii?Q?EamMuqvN+Zpwyy62XdxaxYwFkSq/2eS3lrIklv9bB8Hqjq8EM5qsnq5DzmQ/?=
 =?us-ascii?Q?2HNo5gPh6utjPdIvvVKlau4dF9e1w7wunLDKRUEr+0K0yudlVit5yA241c5B?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eA/hp36CLK6s+oFO8XSc1xKq8VrfwaBRwvn6nTlBwmRBDDxqtUl3zkERzRroG9eCRbtpZFuFaSRiwExEgvXvpXvJKOFmx+rFL4ekBU+gR90/lAFF70adbSpKCfPZ2dfYR4jJUKmCjYLpgvjWCrAt447D1toRHpFnMEV2AMXQ5sewBUxAVn2fYif9KPIvcATdPsbeZkRuWdVYasj0mzdUtRsG7InOh6yJSm7PHdJ3djZleVW9O87FDnWJjboYjMLWvwGHwoUm6hjA7gc0FHksrlN1WhnWQptEPqaUgJHZe5m4hQOngoMW2YTryzAxzDO+u9Lv8Hjmaee4StvmsPRO8jzrv79X0Oq6GXqp7SpwqvaT/rdIRtxT9jTJETZLQ0ryjy3wR582hDv95ISNwhvBANEnufAI98sRk6eaPiDlyCT6d9oCp7LAFBWj4zLUZI9+539Iqy0ReGDcn/R7gVx2dLL7IXLqWW2xn4yLZEE4ZcDq9r+9FMmOb8saIXux7zZ3oa7wZJrBp5z1Ukx//HspkZ/QQH7fAWil6rIaQDrQhp9iEu8TDjXY0mkgGxp6GFyp8S1iD2d6FjvFfMFeM56MGQ3svdpHUhIsuWoq82YWARn1E+VBz7xWLpOFzDCfafPoidLFJU8qvhmTYcBUuVsh7EGtcBaxhk6lOtcuMSh3WBtELAa9+Kf/VshlMb0DpfTaQ/CI1Qxf3hdYt8x0vd+EcYGSNIRb7gcrVmDnLGiKFD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2194eea-ad79-49c5-0bc8-08da7c47d340
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 09:48:35.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3/A8/OKl7ue9SysbaWfI2PLKn5YrCuB3L05TyrqrZxWHGJNEayUciXD3Q33h7SxvtWBvie3olub0WMhN03d0SpyVOCWQderXQ8zl5n0NTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_06,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120026
X-Proofpoint-GUID: uedXxGuSCDve4rXgx_tCODy6jzZN5Suu
X-Proofpoint-ORIG-GUID: uedXxGuSCDve4rXgx_tCODy6jzZN5Suu
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The kernel recently "moved to modern C99". https://lwn.net/Articles/885941/

We still have the -Wdeclaration-after-statement but one thing that we
can do now which trips up Sparse is declare variables immediately
after a case statement.

int x;
int test(void)
{
	switch (x) {
	case 4:
		int a;  <-- before you would have to add {} around this
		break;
	}
}

Sparse makes the "int a" into a STMT_EXPRESSION instead of a
STMT_DECLARATION and test-inspect doesn't like it:

$ ./test-inspect  test.c
test.c:7:17: error: typename in expression
test.c:7:21: error: Expected ; at end of statement
test.c:7:21: error: got a
test.c:7:17: error: undefined identifier 'int'

This causes a Smatch warning as well about a statement without any
effect.  The first code to trigger this was introduced in linux-next
yesterday.

regards,
dan carpenter
