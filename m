Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA1C433F5
	for <linux-sparse@archiver.kernel.org>; Mon,  8 Nov 2021 11:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BD96120D
	for <linux-sparse@archiver.kernel.org>; Mon,  8 Nov 2021 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbhKHLvf (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 8 Nov 2021 06:51:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31724 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhKHLve (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 8 Nov 2021 06:51:34 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8AcH8Z029335
        for <linux-sparse@vger.kernel.org>; Mon, 8 Nov 2021 11:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1vCKTCsvl/9JGRasfDgP0KIP2zjfan5dsCu6CTQHUwc=;
 b=pmjwr/v+tvBm1OmES292HnEXfHUzKL8hKVkkfih2KH5nj4bOqyzqegCdYGICCWYJ1yTC
 bGdKCkWBTfyhKLUTzR+H5xYCMUlE/0BlfjW3sSy49omPtjkl5/mfymLkBpAuD7fTmejS
 QFAAFatQztl9Wy6a0KpnUksMO5zUzTv9Fpk6nps9L3qvcIEx+s3ysyJC9i9u28at8Fft
 Vs9sLpofaVtAlwrN91RpE/uEKR3zOeWahkJb4xFOVllq/Hz+YiqEbNOTU0oLuNZ6rLHD
 86F/nY7oS4/4BXyATy5E+RkrgJgWon8OdhDE8UTWYfJh4EklNnD8SHj0RenMY8rsIVu8 DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6sbk2ejk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sparse@vger.kernel.org>; Mon, 08 Nov 2021 11:48:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8Bjvhj155374
        for <linux-sparse@vger.kernel.org>; Mon, 8 Nov 2021 11:48:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3c5frc6jma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sparse@vger.kernel.org>; Mon, 08 Nov 2021 11:48:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On+JYw7O8GxAAeXGB0W/l7fVdRPrW7wNqk6JJbCadbWPnlt0dMwzmYpTM3lwE+fo6kpL5QU9BdHMWxD7C7AYZKsYrdtVQwTYaK+v8S1X5fI4mf2qn8ng5sKFJ+MZK3Awd+Z1kcu8EduZpwP/CH3sAS7/F25ddjWAOzbFuesG33ARBrqa77SMH+b+QmBYrSpJuHOTBhaRfFhdHToUOjDrsDp0tovOd94Bmot33OHUriArNedrBsB49RI5B58dxhTHoW5+O8ZgH5qt63RMjkcg1+D/3p4kd6Md1cjr0GSffPFcMD4r1iRK+4S9q+NzpH1nif4lG95AVTzYO1RIDlfRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vCKTCsvl/9JGRasfDgP0KIP2zjfan5dsCu6CTQHUwc=;
 b=FHk3kN59Au2TvWBvFl7mO/rz5YkUqPQxK8RWD5wHViYZ8wB15+WYUSodTdeo7D6l8ebXTbn3ga8gltPeWE5jUCdVWd+iMZWlocN/3UhQ543UOEpPsvB7u5mBCQmS7RTP5wdBO415eZFEj3hPrWP7e9KG8CEASsSw6hcJu4Q8U0/fUTrbB1Dq/prh5ZbggeTY2hElLifjlWK+LAapOgruqqg3FfYol9HqQW2lWJFLQ9AK2yBXysfhNAEovfArEy0PftLHlOCJqrVmy7QD58KZS1N8t7Fw5cK051f413rCmY169RwYp5BnIBFOuArckJfc6nQv6sUTwBj0lUo2XKGLzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vCKTCsvl/9JGRasfDgP0KIP2zjfan5dsCu6CTQHUwc=;
 b=r8r99Ow/wsWmw7itT7jkKDRP2hgkgSr0WMhqHzyZuF2UpNnuSw3AFdZ2bmhm1RnxtI3kMw0ogT9slP/PX6ls3irOZEO+nwqYhrtKJgaGwfFHDQkHVd7eiG9hVbTZzo/4qAuSCXw8rZFXMdFRNHF3B29hs5w8TZqdkHIr5Nqi1qw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 MWHPR1001MB2367.namprd10.prod.outlook.com (10.174.168.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.16; Mon, 8 Nov 2021 11:48:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 11:48:46 +0000
Date:   Mon, 8 Nov 2021 14:48:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linux-sparse@vger.kernel.org
Subject: Re: __builtin_types_compatible_p() is too accepting
Message-ID: <20211108114827.GF2001@kadam>
References: <20211103133600.GU2794@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103133600.GU2794@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 11:48:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69f16ebe-3384-4afe-661b-08d9a2adb874
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2367:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2367C9CAD05B141D167C1C888E919@MWHPR1001MB2367.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoEfOr1JFDTIjCLAjS/LLprHhlxSvN8uFBAwvpix1Fuj9o9ec3NY+QJatUCJlx9Ii7f38wo0yBLxTvpnbrVsQLHumonpKXZ3juMr99IFtk4PzF/iVrxhzb89Pci8iIveXOXcsz640dQcpRqQzYRq+NRQG3Xm3hFxOyZk88IYAX0NgIsoOmiL1lHyATJirGSwAFk+RnciXnxeLSVDr/Cd1v4oe0EGGtQ3qmFwMuQYUevFyaA/GpsXUgS3oi552Uz5aaUKcSkfbAyuGIUZNQPOs9//SEK+dWcpCkS3xzuvVUtb9hDzcSLl+B/qPE2lYKofQBolcPb4YNxEp6gxsXFRj/kEGXugTFgi3T+K6QL3lxVz2P7Ru5Mcu2VRYO2yNGrGSYOGSiD8IHjhkXc5M71q2W4SCQMTC3FsjuGjmfqAFvMJHUcQZ+VRhsHy4LS3JhNDhQ11k9TfmXzdtJehePtx8KrFqsIppQ/j413UQShDMfLwpPSYds5l//lE6nx6Vs8nFQYgkvTXp3t0oLG0YSMeSx1uEqiPb8V7n2UtEgabZT7VuAmtwHU5RID+aK2xn0570fIVroIgXPnzxMA1oK/vmRHviC2mO1iAk0Wd6MoWNicZLcE7J+RdD718vHjoAJHKvo2XPKLngCRbTqw51j0PIho0pLEFe8N06QOHZS3szqgJsYfWGyfZd9Re/ScBAjZKrXLvRuFedDXtOmpkhfLyzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(316002)(33716001)(5660300002)(956004)(1076003)(6666004)(186003)(44832011)(26005)(2906002)(8676002)(9576002)(6496006)(55016002)(52116002)(6916009)(8936002)(38100700002)(38350700002)(33656002)(508600001)(4744005)(66476007)(66556008)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kn9JOkwCKRlsZqH9dsEpUXfA+YIoFW+22nKZS5iY9q7r/oviLRIOTW10lV/E?=
 =?us-ascii?Q?1cYt0Yyh8XtLkOu3g2bbChrW5HN8JbnqZHb4PyH7vd0PRP80H1nw9whif96O?=
 =?us-ascii?Q?ZoibVY/b3NZ6Gkf/N3fXR+kd3tn83jVwuLVLbfj3XwvmchEjfk1W4Dgw6sJU?=
 =?us-ascii?Q?EPLUPBAveYB0DW64O1/AUCqZOlIvwmrQfyu7n+GZ8cdMDO8bvtuwfRUEQ/b4?=
 =?us-ascii?Q?ob9pNzINoS4pJFFX8kQmVxx5odP01kMQWK/s0yaJ1cliCLV8BraYESSR9hnN?=
 =?us-ascii?Q?tm4FRrJSE7OeX6RDIkBlzyehsjUzlWP8adGmaQD9fAn2YtzFB02km5Q1non6?=
 =?us-ascii?Q?YDm9rdHfVKG+9K+xw4ypJfWVU1vDmJrNfHirihhnY23eua9SIU9QXa1BET+q?=
 =?us-ascii?Q?cctgTNvYa5KVZz8u1jC0Ym+odAw04yvG6uT62rd5m2tNZ5d7iK568ni8416L?=
 =?us-ascii?Q?pfFhB/k+BMt3HkAdeb8rG14PXVtcaGqtwkbPj6K/IUUcW4kuCBvrU65I+wjz?=
 =?us-ascii?Q?r17/T9uL51iHO17hfBcAVeuEJO7yt63sA+IxbCtdFiSIx8KTfuHnkb1mGMsp?=
 =?us-ascii?Q?LgHkImAnOaEh1o6cbeIbpHQYBxxZJ4DAz46cq8lVjPex18Uv63KAG7otD05Y?=
 =?us-ascii?Q?TNDYJ6BrNUeFcXtVHeAShwPVybcx1yC6adOjl8Z5oF4gEemMcZ1eylANwgKE?=
 =?us-ascii?Q?TCGt4iOIkPTjkHCDtxwpaxu+0oMLhXDaNV+0CQKPVEx4FerwEz68Figo+tYC?=
 =?us-ascii?Q?Z+QIxSWHYxi5mvDkBb5sGTGAiXcIIy44eGDlZ/cL5/dOMGoMn6Hg5wIfx5V6?=
 =?us-ascii?Q?EQJqjNr25JleAc5liYDMtVPucjGtLVEmatwEGatVt9LuErF7lAat/PchgBXx?=
 =?us-ascii?Q?EoPO559EgOo2Ee6iBDfVJ3mf16+APEPnlHmB8+5zscA7lRMmdD0cDKRHVuM+?=
 =?us-ascii?Q?3h2vOXVByveenSO3qVbk9GeiQB8DW1tlUYGdtnjJ25G+nD/aF8bKEAlzdlsg?=
 =?us-ascii?Q?jCnE1QM23hKm6WfaS8Gr4qbFqzPgohpVw7yNl4d6AXiaW2WhsVi2R94mzphA?=
 =?us-ascii?Q?WsSNm/91gg8G0m6lrpbrauUqeH8N83rWbkDF5GYnSG6Qt1ZYhjY5NfZIfYaz?=
 =?us-ascii?Q?BaoOnlQCcZQgQz5dn1SwV1qmoyGlzJE9uKCdH4eDDhxLUplQM+HWKQbGyMtm?=
 =?us-ascii?Q?owxCwuSLkYBEsXsEnOLOZYwj8H9O+0bLEnNPkGp6IwBg7c+dl/JHti1+zSMj?=
 =?us-ascii?Q?TTunhe3FHnUHaC/Q9570bf5/NC16+ZOoDAjZQVUhXUPT5artiphVZnmLax/H?=
 =?us-ascii?Q?OiT/+RR35SZEm8y8oOttvzhenG2OSKlvB+s1PcCnGX8WD5Hw9guQpkJZJSUR?=
 =?us-ascii?Q?sKifxwbelyMQMAbWGdt4V0O0yVBPQ4UtdP+1lBKqFoaLIvSm9/hgidCojdud?=
 =?us-ascii?Q?n12eiupeY50MlFWj+pcd/xD0ONStapfjlRzd5qRbDniGZxuopdkUM+V3EWH7?=
 =?us-ascii?Q?5h9UQ+IKmcPyBHm+cbVAGD4XOc9yZ3I4XYksi9V/8rM39dJTgowWcaxqX4a9?=
 =?us-ascii?Q?8xVnrvWLaZulkCHFgpTbneeJ2TvM8r3SFK5+9LyYrhgFfrLAD+r2DYF9gmSv?=
 =?us-ascii?Q?L0DrB5m1BbrIvWskNQ6rGqq7s2J6a8xMDzK2QdxSdm5cb4AYiGSt/VmyIfzr?=
 =?us-ascii?Q?Wyzdb5t2SqwTI9eDzWzu6XQJ/U8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f16ebe-3384-4afe-661b-08d9a2adb874
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 11:48:45.9522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me8kJqZx3WqFxYa0AGglVuqORyoEXEPdYRnR2mOGgfn7pW6mTkFuSi7yS9BUfOdO4dF4Eq+VgysY2mSjrDRCtrHO/ZwrOSAKJkHtagmH0/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2367
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=870 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080074
X-Proofpoint-GUID: t5rFyyzOI5kXY9SIhufuWKuwyGeUfgit
X-Proofpoint-ORIG-GUID: t5rFyyzOI5kXY9SIhufuWKuwyGeUfgit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

n Wed, Nov 03, 2021 at 04:36:00PM +0300, Dan Carpenter wrote:
> The kunmap_atomic() has a BUILD_BUG_ON(__same_type((__addr), struct page *))
> which does __builtin_types_compatible_p(typeof(a), typeof(b)).
> 
> The problem is that Sparse considers "void *" compatible with
> "struct page *" so the BUILD_BUG_ON() triggers but GCC says they are not
> compatible (which is the desired behavior for the kernel).

Sorry, this was a bug in Smatch, not Sparse.

regards,
dan carpenter

