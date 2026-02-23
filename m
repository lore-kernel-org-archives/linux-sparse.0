Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB532ABCA
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867229; cv=fail; b=V6bFp1nawLvcO9FghIX7EjUaOdwhBwkFdiAIimqurWhtO8VTowV0lLbcEWX9cr6GupGO03tUL7njaCUd+52AhgCR49MPmj3RMDUI4Ux3kHMEweXRnA9oQ3ejezQnqGAUXVjRIQ4vdrU+3Xsx8za7ud6IoLvtVr8YsViUin1gky0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867229; c=relaxed/simple;
	bh=ld5LQD136L6fjsErJxzBPqUzBFCqP7MZ4YyXsuUX4m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZHOEOMixxYZbjsQzokXRkZC+UPvH3qs7m4ZPcLxzz5HGiJVmEAXn8dbziQCoeQgLyOHqMD9yb4Vs95QldT+5kvfmaiDWMIqxxljix3Z9Izdkpt2iOSv8RN2PTMQLOwrS++c6ptx0KDukp6nY6XeUTjKnE4pBgKeoKVmgJHWG94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gHGaLC9z; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=UnDtQal5; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gHGaLC9z";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="UnDtQal5"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NFDcRI2145107;
	Mon, 23 Feb 2026 11:20:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Y/M1CXaPYQdzRJNU0xUKi2+UejGsCNTDnyQyK7d4d1k=; b=
	gHGaLC9zX1KLYkiCc9afQlxqjMJ9fw8bXMv82HWDdnZyRafNUe/xqgk9iLQpKTzA
	GxRIs5pQyM3TiPbpuyT0jZrw+fnM7g0MMUIpysON67hBN4lQIt42Eagz+5s0LUfq
	kttfeshDOnhGmBbxnP0GFiwEnov9tApPxSAQi6H2H2dDnvCpngjiAe9/bQgJHk6G
	IXWiPFUmwPUDiYdRBbHz5O4XbX8LsoAOxtkt2uZ65IzZBkqvTUV58ZF76wfuo2aa
	115CM6Gfl7CQj/lnM9CvKXBFsDnrzWp4c0IPGPxxEpK5Pgugj3pUdBlDJWiKiset
	2sPyi25oLITneLUh3yTe7A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021106.outbound.protection.outlook.com [52.101.52.106])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4cfa0j1vv8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:20:20 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gkzj0R4PWldj4el/VYwpq0USPROG+QPU39jPu1iD/yXXCcvsTuLzkTNbm1sTASdLmBlXd84wmGiplzlQmA8zhKjXO6+QX5z/wCKCAweJdI/HvsOIgP6O6ItgFciK/qvkgJl3G+zwEd3wHoMiGCbxj68RL/Jad2KkCM2xSGhdV8yCUI4J0A0629wzCA+MN4Y2ML2tY5LmZpEeGeFcTnd15csCjGEquPLnxBsUq5XPllIhIUm3hS2Rm0/zGPbuDQNMi4XFZa4+HQL+tdyWeCVidAcZgqCuYxXep+R9xXYnUc18TsNUHLRg5hgpIb7xWb+lAMvSlvr+NHHRHIo2ROhGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/M1CXaPYQdzRJNU0xUKi2+UejGsCNTDnyQyK7d4d1k=;
 b=gwrbDab3rwrNX10EwRDEJ21Ce3ZfGkvGDiRay1OT6mUgsQ70Dc7XjhTdPcZe7mox9inRScAw4hVwW1i3KejdFY7dwrVgrtbedUA4Nqr5nAyV/7dLwaE72fNvfUBJd+CvoXmf8Uow6iEU+jOyYDH9TQUME1+np7/NuFHfqqQvUHJC7U8BxiAhxOvCC5dL++xRC3OjGSilMHJtnqKTgeEkx/GBZGYLKTkBBte+h7mqzmBZWu80o4pC0f0HMKGTaI0db8mLiw9T804WHeY1p2LlCNHS4ATjSg4F8ZSNgCRa4lP+HR97XlogSuxxxpAXYoUQ7d4QJUOecvKgV4czuOhP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=codethink.co.uk
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/M1CXaPYQdzRJNU0xUKi2+UejGsCNTDnyQyK7d4d1k=;
 b=UnDtQal55wy2mMaWeSaxG+65LEXZ8Xem7jpYGD2GmgMPB18R319BVDLhyIPA0wZYIHVm18ECgj62+xkkH3YVCESYLz/2VDetOVvUoPetEwd5onDPQVzR9foTurS13JCYxpSErRPtYoAQ+Me52UtOazZT1J/7xXg5NDh7Sb9hZkE=
Received: from MN2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:23a::22)
 by MW3PR19MB4251.namprd19.prod.outlook.com (2603:10b6:303:4a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Mon, 23 Feb
 2026 17:20:17 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::23) by MN2PR03CA0017.outlook.office365.com
 (2603:10b6:208:23a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 17:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 23 Feb 2026 17:20:15 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4A37A406541;
	Mon, 23 Feb 2026 17:20:14 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 365F882024B;
	Mon, 23 Feb 2026 17:20:14 +0000 (UTC)
Message-ID: <f41dd0af-2b47-420e-8999-0d4149ea4a60@opensource.cirrus.com>
Date: Mon, 23 Feb 2026 17:20:13 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hang with current sparse with upstream linux arm64 build
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org
References: <174fb380-6711-4305-b857-4b1ae86c74de@codethink.co.uk>
 <54d24dbb-eec2-4759-970c-4d7d3e48e6df@codethink.co.uk>
 <CAHk-=wijD-giccF6sJ+BdJpGDX9kPEUT6kryaQG0GRyJ3QQwng@mail.gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CAHk-=wijD-giccF6sJ+BdJpGDX9kPEUT6kryaQG0GRyJ3QQwng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW3PR19MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b797c7-785c-426f-189c-08de72ffcf58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|36860700013|82310400026|7053199007|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ai9lejk2L3F5TjYrNnpvMi90Z3FXNUwrWTVIelJQSmZsVTNMeTgxSVpEc1kr?=
 =?utf-8?B?Y2RLQzJheU5sMkR3b0I5b2NVU0JEZGcrMW1ENUZUTkQyamZFQkVHUDYwV3do?=
 =?utf-8?B?VGp5OXJMMUpndjlBMTJFdDYvalQ5bkJsYnZmbUNxcFQ2MlEwQ3pxZ2ZaRkxV?=
 =?utf-8?B?cDNhdmRQdyttd3BtT3p1dmMyMHdQRGh4bUhrc3VOY2NHbUxnejUxTzBUWG9W?=
 =?utf-8?B?cW1Qb3QxSE1sWlNrZ2ZOTXhuUDJRTlRkUk1vL0srdHdJclVkNnBobFFmQ3FO?=
 =?utf-8?B?NmcvUnlzcnNBQXcxZ0RuUXJMRm0vUCtVUkJlczRJRzc0MHRXcUtlSUZQOFEw?=
 =?utf-8?B?V1NOdTdiYnF5eDI1YWhyZitZMzhSVW42SXdHekJCQU1ZNnpEUjh5dHdiUGl4?=
 =?utf-8?B?eDFDODBmZVVXYWZaMzZUaHRXL1ZFNGF0MTg5MlBTS1A0MTJxYlk2NDUwSWVp?=
 =?utf-8?B?R2JtWkRpSU1Hcm1zU0FzcWx0UWllQlQ0d0JVeU42cmU5OEdnSTRBdldrNjF5?=
 =?utf-8?B?Skp3Qy9mYUN6N01kWWNvdkVURVlraUZmM0dOaDFPQXlreW1PcHdSSlBhaEFS?=
 =?utf-8?B?ell6WE0rRElOY0xIMjg1QkpJMlVIdE9leHJxa3Q3Q3hoUmM2a1FLdXhiRnRO?=
 =?utf-8?B?Wnc0d09IWW5iUUFSRmo4clN1WUk4VFpOL0JmZDRUY0FacC9VOVJheXZRUnlU?=
 =?utf-8?B?RS8yc3p2eGo5czRkRDNkSXRLcDcvazZqZllZUDlhb2huYmVNb0U1cnlmU2hK?=
 =?utf-8?B?VHQ5QU50K2JYMEVHeUhwMERvYUhXNmNITGFKc1VhUGpRK0E2eFkwOFlFUmN1?=
 =?utf-8?B?VzBCWXZnb0pvTUYrRFkzRUtzYjQydTAyZVQvS0IzOTFreUV4anUrb3oyVmkw?=
 =?utf-8?B?MDVXbWp0TXhIRzUxT3pZREhDSi90bG93RkNzenhuSUc5MG85UWVrcTNQT3JJ?=
 =?utf-8?B?czZyZHRQUmtXK0dUU1dycTYwNStrMUorbnhLK1QvVXRJUWxkMlJXY3IrdlVu?=
 =?utf-8?B?MnBXbXprdE9BOEJ4bVUxT3FVb2VUc2JPeVdNRGtVQkF2MXkyWGZJM2VYYndP?=
 =?utf-8?B?YmpqMjMzcFVPVnJUcFNucjRuYmVPaU5xNmtvUTFkQk41czZyaTg5cFgxYm11?=
 =?utf-8?B?RTMxRlFraFdEcFVtUHhDM1dlSWxqaWNISm1IVUFkeEswUnVJRUJGTWgrMG9m?=
 =?utf-8?B?bmRLZThMM1pwb2ZVK2h3WEc0T0luMkJTM3FyeCs5OUpvY3dyVkxDUGczM28z?=
 =?utf-8?B?Z0xKektQMCthd04rSlNOdys4OFJOaU1DN2tRU3VWU0xneXlwSHRaRGJCUUJD?=
 =?utf-8?B?QWEwNnR6cExJUXkycFRXR0IvOHZPZEU3aVlZWXlTNUtNbnY2dWZLajBqOEE4?=
 =?utf-8?B?eGtpTUU0VTRFZGIrdnZjbzYrd3hWa0cveUVRRW1MUTBCWFRLTGZ6ZjFxSVVm?=
 =?utf-8?B?dnNuWjVhU1huK3hDUDFHOVZwU25wbXJ6SjBmS2UxZml2bWVZRjZVampsMGZD?=
 =?utf-8?B?L1U1ZE0rbVBOSElRL0E2L3BGZWJXUGcxRzN0WW5zdW9MYW9WTG43UEQwWW5i?=
 =?utf-8?B?dlN1WnNZdUMwTjZsQWhicmxUc2QySDRja3U3cm9sTEVKZWFIOGFYaDFSaTdG?=
 =?utf-8?B?anpNZGY0eTlyeThLSkllcnQzZzgvMk1EZzVicHI0YjlvV1JXSXhVVFVkbU0r?=
 =?utf-8?B?SUtBTURERkVuOGk5M2RVTHV0cUpGWjcyRU55K1l3dURVRW5iU0NGeHVJaWVT?=
 =?utf-8?B?dlBMS1NNYmdMSkozcURRMGk1b1ZiamhXcDhXWENvREFSKzY4REdNaVlZdGZR?=
 =?utf-8?B?MzdnMytuRGlaWG9HT0kzQkJVbm9ZZnN6R2hCRHF2UERGNi9PYWNFY1RaUnVq?=
 =?utf-8?B?MTBYVkQ2cnRPLy9MRGtSQjk1TmR2c3FGeHN1bEYwZDdnTWxxclhrbldGQVJL?=
 =?utf-8?B?b0hUVmRiU1FBalV5ekRDR1EwVWdxdHZBcVdva0JuK0JyYmlINXdFb3BnZTNS?=
 =?utf-8?B?YVYvck1TZDNieXJoUzZ0QXJicmdDVkdXNVYyMHV4WTcxS1NITmlOdjBlckt0?=
 =?utf-8?B?ckVIajdTRGJmYmFVVzNiSkhYM0xac3FZRnFqWGlZOG5zMjZKcG5aeERFRktW?=
 =?utf-8?B?ZXRkTUF0VkR3MDFNOE1lNlErV044UWtXcnRRYzAySUV6Vit0RGx0SEhlbXVn?=
 =?utf-8?B?eFZWd2hwSkRpUGRMeGFCaUZTMnV0Wk1XdS9nVmNHeFJBRkNEcGVEZkdkUWUv?=
 =?utf-8?B?TTBqVXZMdGpJL2sycFVOWWtQY21nPT0=?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(36860700013)(82310400026)(7053199007)(54012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eiZFwz052p4lE3p0hQtjGBh3WujOAJXi9ICsAWI5qam7xj3n/cvEfRj/QUrr2NtEvjxdspikESBnzqEqDbVxWJiN4nCeUyYaUJD9pRgndCu8es2iBUPmT/wj3fi6z8kqZiLmIYKWWy3kw/wFBDxfquez99/4G61Afsj0w+pYeLrwe7OGGGFn5ptzJGhdzHaiwBLn2BhTtxUv7do7am9eTnFYrg5wgBUgWqDR03AEmRtKEZwOE7SWPiMFfWlBpfxP1N0F+4WNZfKKLhkdbJB2pImEgiFRpPHtnV1Y2jtnTHb/kX2VHAbhcbZG/w4EMsIJwPqS5fK9A2mhHmZ0vHC66/R4kq2NlSwDcvCsL5bFPR5/rc9qbBs3Wa1iBQTqkC8lp9G7ej8ppV+vDKziWJDcDqihvq54tPQG56Rbrfz+MBBk6IKfdiwapIpq7/7K1kf9
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 17:20:15.1858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b797c7-785c-426f-189c-08de72ffcf58
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4251
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0OSBTYWx0ZWRfX0xGauHU7bpvY
 Ll4Jd2tVuUMEjsij/HPTu67p1pDeVpw6D0XGjW4723m7wEsDoeD8/krmsNnHsoCIscnA04wx0Ey
 dQCkPPvNIo1Uwq19SA3LWmQobQ6XxYDE2S6smFWs3qQYfhhrxZc2KJxPxmyW+J2uW8XMG3qLXsx
 LMR5nc58Hu49vOW1pz/yse4Aqi/e+iPCMwddDRy72NSM1llUYgE9ENvKRObUIQd4pkoqhNGJ2uf
 rfXWqbjzO9ZQ+nQmC5dh1O8k5fI+4bF8vil/6juTaCoOQArtFmX2AF4OcqxU3JPS+wen7VPmbWD
 d1dap619oFJpiFNYD+fBXlnDVUn46zXml0HM/46YGJht6N3nlrZYo/SmwZpqxm8AwUH62TYGhYo
 uWOsYZyJ3Iee7oiFL+8v9LUnCoMJxlMAxetvTAce7jQu10RRfWq3cHVFQ1OxFCfAI//o+2LZrbF
 FWm6QKBOO3LvoS4WdSw==
X-Authority-Analysis: v=2.4 cv=Q/7fIo2a c=1 sm=1 tr=0 ts=699c8c54 cx=c_pps
 a=8AR2Or5FcovIRbB7TUUKGA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=1EsaE_6oAAAA:8 a=Sz44mvnnDuPYSl3pZHMA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=3ZumFrijQQ-2J9H5h8ct:22
X-Proofpoint-GUID: aaD-WKu1KHBwMi_4imBbO9F3-HcC0tW2
X-Proofpoint-ORIG-GUID: aaD-WKu1KHBwMi_4imBbO9F3-HcC0tW2
X-Proofpoint-Spam-Reason: safe

On 23/02/2026 4:43 pm, Linus Torvalds wrote:
> [ I should read all my emails before answering them, but I get too
> much, so here's a second answer just to make sure Ben and Richard see
> my first one in case they don't read the mailing list religiously ]
> 
> On Mon, 23 Feb 2026 at 06:08, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>
>> So currently it seems to be hanging when checking drivers/clk/clk.c
>> doing the following.
>>
>> $ make C=1 drivers/clk/clk.o
>>
>> This is working under v6.19 and not under v7.0-rc1
>>
>> The git bisect is pointing to commit e19e1b480ac7 ("add default_gfp()
>> helper macro and use it in the new *alloc_obj() helpers"
> 
> So I think sparse should learn __VA_OPT__, but in the meantime, does
> this attached kernel patch fix it for you?
> 
> It seems to work in my tree, but I haven't actually done anything but
> a very quick build test.
> 
>                 Linus

Only tested with a single (Debian) X86_64 config.
Builds and boots ok.
