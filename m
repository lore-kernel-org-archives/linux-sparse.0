Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED9BC433F5
	for <linux-sparse@archiver.kernel.org>; Wed,  3 Nov 2021 13:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A178A61076
	for <linux-sparse@archiver.kernel.org>; Wed,  3 Nov 2021 13:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhKCNiz (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:38:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9610 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230472AbhKCNiy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 Nov 2021 09:38:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3D6Bt8009492
        for <linux-sparse@vger.kernel.org>; Wed, 3 Nov 2021 13:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Zd84ff81lZWpad9A/r4HxWMbjcACSGNlCmqdoyEiutI=;
 b=cfj+TXPcf8wNjrV30TDt9bLshKFoJRShrnugJdGBJrrh2NEsQiQ5K0waS1z/8TcJ6obS
 s8naNJ/IFAozJYxMuu1dFrQk7qsNg3FCy4q+c6z6L3ytiSEDfC7Z9CnEynal1XzfWPg9
 ROW9jqnAAYoMthz//K2YVEEs497CHjx5+AlJ+fDWxzWEqawiKKprS/kabKWb1GuDYJ9C
 0xx4nGdEEWaEf7AhwSPhAW46ci4B9lRhWrByreJAO6Iu8N7aB1MEmsQvSu+XTrJNJ2gk
 NIqHF9PCWGonECYat9lCWlLxdK9idaWmceehC7qEpZo5fZKXVxxs9MGI0hI3d8Ui4tRk +Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n8p1sgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sparse@vger.kernel.org>; Wed, 03 Nov 2021 13:36:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3DVe8U131112
        for <linux-sparse@vger.kernel.org>; Wed, 3 Nov 2021 13:36:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3c3pfxmp6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sparse@vger.kernel.org>; Wed, 03 Nov 2021 13:36:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktI5l4+U6eSubwYBUDvgD/ID21eDsE6kw0mcLSl9scxoVYoLbofYxHm9vOwfTcB3iPHiA5DsHJhA5BI/PWGjU+4V+rkMcw6f+w/y3qey/hRTCibPEwuaZm4EYHb+/PN26NN2SF6RUCQwz6Sd0hYtRHPfn65t8XDo8ChZBruz8lYgkwUVf02U3rgt2/nEJIf4vmuJBG1Ld06/l++8hQch99/eQmaKB14xTe8Eg73VEAsLdDD5ga4hci4Nz04qpk09g1bNtrRoJoe5SRi1ry+oJhjIPDSIShpLCFnBrZ+eGtYngBrnOTWR/2YjfV07SeOtdP0qsXAZkIhFD1qsWvzNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd84ff81lZWpad9A/r4HxWMbjcACSGNlCmqdoyEiutI=;
 b=CPYCaOqd2nMWJvDrqSbH3uaXtDmWM0ZBlV4wNHf/L4HOhAV1utOR551wkJnHEB4WLEdyz2OTkLYc2fOCUfI6YTN5IiYFEZBqmOs4n9shJh4AEVVUhkBzJ6KByrb6K9xDf1xsxrIZ6dyC2yTVcjC0D6MqFZlvMiJ4BsoTbyn+L/F07ZpEsRrq2DMkKDTaMrtmn6+Oq4yM85yuorjDLTlGJUpPdTE6uVZ1/juJVOlcsXASKyXx+3XqJDben/f+d54taMPIjB4hjUYPzR+bJJDYOzDYBSsCA+XJW70dPeeGMgb2vRJRnKuMuYAriwwHzZTXJIM4D8wukMTZgWqjjyi2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd84ff81lZWpad9A/r4HxWMbjcACSGNlCmqdoyEiutI=;
 b=nbumMgqruoN2nS3N1VLjJkU4VzXFzxJ3zxqZ6jspQVJmbaHaJuqckY8wezK9t+rTRngvcbnCuNmPlEL1Prl38UMTODo4oSIaRlU/7QyUPk2AlHvs2mLk1tFUL6HsWfc0cBaBZB1TklrW/Q3U2kYrTKM/kOGbAQ8edxVQ9J7nrsY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1527.namprd10.prod.outlook.com
 (2603:10b6:903:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Wed, 3 Nov
 2021 13:36:15 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 13:36:15 +0000
Date:   Wed, 3 Nov 2021 16:36:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linux-sparse@vger.kernel.org
Subject: __builtin_types_compatible_p() is too accepting
Message-ID: <20211103133600.GU2794@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Wed, 3 Nov 2021 13:36:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e42e95a0-17fd-4ed7-037b-08d99ecee84d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1527:
X-Microsoft-Antispam-PRVS: <CY4PR10MB15278416BE9430A1FD5A07DB8E8C9@CY4PR10MB1527.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si0KsJIAKEAW/AysEsA6a91G/+/V/eiqHlisftjSiYC9MPCbZDEyJX6zGvNGGrG0KRIezxHjm7ewdqMMwgwIhBLFjCdzVgwvSFaRXBLi0HrfhHhIpTzvUgdxTrK0Xu54y9eslG9+qxu3fGNKBLANayriW/WZrSWLXYYxoSuzrCdAcunWj8YAb3ucxJ79oiH6OHcul5NNfbDxuVHE0aKTzhSA53Sus2jJAX645YTqcINznjgn4NS+HsB6nDgXCl6ygM9BZ3DXMLbJWnjrVEUn233aVKF1VNkooZ6I1F/E0OcBBC+RFTuuyT8ek6D5obniYvXd+UGQT1WPU2ftcVuSOiJN9zwjdC97rxzJ/Fs3MbKRLLAzdVxUu7MIqQ5ALxSlH5mmw9eiz7pyTTDArvtzhCSF+JgEY1d8iz2/qSz/fdxeACyz/1wcOqtbldNe823zNusj1VG+dE2sT1b3a9EXGPoH67ykvpjdteLRpigdGIkAobrzJN1OIVRJN/UCS43l9oqiRE7IGuX1xILuCKTHrFq6iCoVgvqan6ThnlzYDtOpDQG0oVhkBzsgwWDwKHdKr7Ge4gx1/pvmx2RY0mkf9WMkCvQ4frbX4DXpl8g8aA0RwcKizqZcrwBCZmIc5Vc10Dt/sjqJ33kwSuWp/2EbpQcF3M0yJ3m02n85SE7tUl3wDy0qvaEVrnJUTYrbk9UM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(508600001)(2906002)(316002)(9686003)(52116002)(33716001)(956004)(55016002)(6496006)(186003)(66476007)(66556008)(6916009)(4744005)(1076003)(66946007)(26005)(38100700002)(33656002)(6666004)(38350700002)(8676002)(8936002)(9576002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RpYaLxQsrnbYiTznvOToOvkaa9HTEhLnK7uqyghCCijMpEvCQX2lFAZnlhBl?=
 =?us-ascii?Q?0WBW2bsG66pWHnZgqokXOVPt72EnZ4XOGBJY+rcUsx8xjWYZPmwb1ZIXdM7d?=
 =?us-ascii?Q?g3WMZFAjrb7oqg3zkVX4Uv4EyBFDrR2+gc6/Y3bxDeoYlg/J7jAHYDhGPIOV?=
 =?us-ascii?Q?M2Di7GRUK2cf46FSrLDt1Um0FLMKsOlVF+QgbKTHDR/ToM75d/ITYYrEaXZD?=
 =?us-ascii?Q?2EJvx5Dg5/roSw9L2i0jW1s6hpT0WZe4a0nyGUy2k9LLEE7iCtXHs4B8kqBw?=
 =?us-ascii?Q?q4lFVpMT+qfJ2o7pZdbDcvLGUvXdfQ3b4nEf7ouOETCJDoYpQMVMBt3WlYDu?=
 =?us-ascii?Q?0ydk3uVgoCse8D2QtxshXx4bh5OOMZUXZBUVtJSE+jU2T8ydLDM1KAFj6IxO?=
 =?us-ascii?Q?9QyT7n45qCe5jUeqRDAbrJ5sctQs+x0nt3S5ZPlfs56yedtK4FtidLmvfZWF?=
 =?us-ascii?Q?HNa34aVwvpeQbc3n+uRmruuz4e+ogoAAoFlzK5CsAClF6UVp0QMo9IG9AtOX?=
 =?us-ascii?Q?SGTVuP8GYZa87eIbTHhjP2bLFlzbGdHj+lPxxwiEF2l0pTDAKc3EvjIRhewl?=
 =?us-ascii?Q?LoxZigWcsaiF4CMapOcFB13EW98vOOwnBIrvT9bIajLeIwm5hpUy0oLmxrvX?=
 =?us-ascii?Q?mlhvr+UrVuFnv0S1Qi5dhG5HgBOLfY6C0tHKVHvZ7mFPUfZdsbEPrcOk44sI?=
 =?us-ascii?Q?/1CCuEMoyTZqi+eqUY3Ye3G5kXQtHHp9o60+nLt92M6/HQMGnbBUqYe+tOG8?=
 =?us-ascii?Q?302z7JTqcgzF4fM6v25x0onV1x2KLKJvoRGpkOEAuNGcTzsTAAu6I1etvYSB?=
 =?us-ascii?Q?YghGCLc7OKG7nOUomX4k6nU9m0MU0OKkq5GyO2m6FcBCFZbTO2V2RXH83zOr?=
 =?us-ascii?Q?YHVOZXcGfc8+1y/rhdvdNncX/0G5W6g/OrewZn9c2WbH7uAceIiVo2tz7+sQ?=
 =?us-ascii?Q?MRwcxL5w7YXrbs5gN6nyLjFzig6A+DuLPX0BACkcw+EDPqbmkdoCXv3FPSUO?=
 =?us-ascii?Q?6MLYJCOlGauJyPgiw1ZxQumyg9Qv/YQZRff9I7FJXsi1rr5OrVfaVIbj3CKl?=
 =?us-ascii?Q?UCChUe7l+oKqewIINAyWKfaD6zif+HE2k6XbxUyN/Y8vVI19tvJhgZR0EStM?=
 =?us-ascii?Q?ffNmSXtEP9qh0Dnk4ExyMdAj52LFB+ICsCcmbnURwRgbvWC1PXaO38H3Gb+/?=
 =?us-ascii?Q?c8z+ZTjtpW3MT/GN4rKpTM8xRl5aUYg1dPh50/epJ5n4APwF6Z1gHURO8IcD?=
 =?us-ascii?Q?gyUC+gWG9dkjmjqrtZKDUGsmhScfm5tZdw+YAlmJESDWi7qkeR/6zrQc9AaO?=
 =?us-ascii?Q?96MWXn4vUb6SQbV/PbxM7MojzVFXd6ytWpNyTPPU2a9lU+K3IFh/Lzm/j9mx?=
 =?us-ascii?Q?TMh2DhxL/W6uCNXzMCOzBu/tzRzqv1fFDCWs6MUbc3HMjv54Eii0dyE1d59x?=
 =?us-ascii?Q?kfJNEDQjATWK7Fo97vGAyQmf3/IYxIRAPBQg/hQBshnvhSNSoiJgNA0jpV7f?=
 =?us-ascii?Q?aB67IXFaxd4SZnM61JBkIN6hfWEeO5BAiFkCWKzpbzOuhzRCHtjh9XbMVRrH?=
 =?us-ascii?Q?Io/cJAtK/OmWfwa6E6ETdOSpXusmjN5pvxdMC67TS/UzmU/bPcFkt3jndQj6?=
 =?us-ascii?Q?WIdX9Lg1hN1fE90nAWp3P4ZKE7PiPFRJ+fTxbK9oquTpD3GSjtX7kp/jjoRd?=
 =?us-ascii?Q?lKwZxQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42e95a0-17fd-4ed7-037b-08d99ecee84d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 13:36:14.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2boyZuJu7GtI0f8FWe3TtXPbHy+Ix4lxcloBZnCw3vBa83fJgIHHtzDgx/FKO50buPc1O8i2QE1N0dLrZ3S44ZG4hGDfu0+Dj5sHBDMnYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1527
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=575
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030078
X-Proofpoint-ORIG-GUID: Z5VLHefCi3E7UaICoctpqa1EBXL3ODy2
X-Proofpoint-GUID: Z5VLHefCi3E7UaICoctpqa1EBXL3ODy2
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The kunmap_atomic() has a BUILD_BUG_ON(__same_type((__addr), struct page *))
which does __builtin_types_compatible_p(typeof(a), typeof(b)).

The problem is that Sparse considers "void *" compatible with
"struct page *" so the BUILD_BUG_ON() triggers but GCC says they are not
compatible (which is the desired behavior for the kernel).

regards,
dan carpenter
