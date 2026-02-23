Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387C13D638
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857999; cv=fail; b=CZ3Hvp3qYTvx5zwdCb3aAsOdRUVy2zZekE+U3RszwPz6vdLct/+RYA3ac+IqAlxsvY5aF9i9ZrXf4573QW4wgBIla9q4g0HNV2minji1oEh6qzxRAehdRcIfV4OdqJyLZReOaRyVlJPueBLykhx97xIhh0yAe3jtFc3kJAcwUdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857999; c=relaxed/simple;
	bh=PX0D4P8MULKxCLhTVLwEYGZ+MK6nPJLwhysjrviQIPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=OWfL5gCVhduiOQWMheVv9rccDSWSPXFpSnxTtsd9uxr7I6rrPf5AZsAP4T17tZiQ9mZnrffuu+KfVD7MYhZM+JFw2DgLNOQtFUcFHRjXA9No5aILCaCUDo7ZnRuO56NCscpfxSKzE1W699M1KnrupEhKoOIoEyY5roSx+moYGYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=l4UPFsRe; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=aATsc02D; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="l4UPFsRe";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="aATsc02D"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCa5J31878262;
	Mon, 23 Feb 2026 08:46:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=XamZ1vRvyH6Y5901T4skTFnShvKQE7jIkJvHlwNAILk=; b=
	l4UPFsReBlaky5URg+7GxkILHcONS/vh+Y7KV/3L2je0GY9G/1VaWhTP9PtJZ9k1
	9we2pLU2DxyqUJw6oK89ZGsn7zH+YYB2B5vTsQ9wkMNH0zD3OsdoaFCW+QZd9kB+
	+bK6ikqJ1MxrSEM6jcqsV2N4JppymHtz7cAjBsKJTUvo3RUef0G0xqV3cLxokifF
	iuEdV7NhObVjUHoM6j0b8a0Fs0EusdN/epDDOlt0s9VvIVcMlzzrXB/+egkB6o+Q
	gkjKDa69eUOnYhQCOxtCXINHTRPgkoLIzLnWLZyY3co/hz5BfTo1tOaD+otu2QEF
	R5yng0NQ5Co2MW5KeqSx5Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020085.outbound.protection.outlook.com [40.93.198.85])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4cfa0j1n9v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:46:27 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpBDlakO7nLtKLf0PWUlviHoh8ROqxjym0C0bfuCKuMgHdX8JJ8S5Pkxlr4t/vHa/ZBHoMR4rwQ9GYOlwXMA2//6tyw93rU+um2skAy1yj0f9P0ah635uu50n5m9eT95pHMY4U+2wnj60+8wOoOk9DfGYL4CL6SzhT1bK2fid9GiNdeRlDDkNf0WSiga3stXdxoYClqfV4Zq8yL1PiL6shzUoncrsGv2xzXEGqhR6KYzmTFpWjFeRM0rbexyCtmoKemi4NIQHhJlpisHsHKx+DmAOHABenSF6kljlAbIpnBU2Ymrf49WzWLrtHLKAjEjVdXKN+VvzCWRWkh33MEzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XamZ1vRvyH6Y5901T4skTFnShvKQE7jIkJvHlwNAILk=;
 b=bbykV1ywl7oC6YxK3a8lPUPm0ZDF/jJ2Sr2YX+2nQYrBugsMXC1SJRKMGoNKulHDHEr2XkFNEX7tbMPXNSFudHEDNYNwnZ90ob9eeF3ejLdfOOlSe/YRF7rmcFSQYYl6kV6aUpHDB9RhEIH+efiCrl/18vaOcXiTC9nGgIlXiUTW6xIvtGLrWv9hn5LNpRd0zpEXnAIstxAZiHEdKvRL5kWUgCxge5pSJas9oZ2qE5TMNlgzdtP01kq2PYtnJFaL6r4WymCe2qE3E6jIwu0wrE/dSJYzBL4iTeP9diEEMtzKFTSsQXL80OnnaY/23qaUz2lKGUkB9w61CqE4c3ug3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XamZ1vRvyH6Y5901T4skTFnShvKQE7jIkJvHlwNAILk=;
 b=aATsc02DHjJ/2rYwqmszmhzuUxLKWwmrlqCtf3gdAIolqGA1DFwP0ua+BOv7IbCv7ormqSoW/g5HU0FyjN0j2Edb7vz8jo+1BwMgyoaWRyPJmQFSOqYc90YEMzk16M0Hz1JUds61TmJtAPvO6l2SjuNmjc04aHpCG5vD4eaJA5Q=
Received: from BL1PR13CA0133.namprd13.prod.outlook.com (2603:10b6:208:2bb::18)
 by CH3PR19MB7907.namprd19.prod.outlook.com (2603:10b6:610:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:46:24 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::54) by BL1PR13CA0133.outlook.office365.com
 (2603:10b6:208:2bb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 14:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 23 Feb 2026 14:46:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A71CE406541;
	Mon, 23 Feb 2026 14:46:21 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9F67E82024B;
	Mon, 23 Feb 2026 14:46:21 +0000 (UTC)
Message-ID: <f6e6bdde-3cac-4e74-9f80-1ccce895fe5a@opensource.cirrus.com>
Date: Mon, 23 Feb 2026 14:46:21 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hang with current sparse with upstream linux arm64 build
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-sparse@vger.kernel.org
References: <174fb380-6711-4305-b857-4b1ae86c74de@codethink.co.uk>
 <54d24dbb-eec2-4759-970c-4d7d3e48e6df@codethink.co.uk>
Content-Language: en-GB
Cc: patches@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <54d24dbb-eec2-4759-970c-4d7d3e48e6df@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CH3PR19MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac4678c-1560-442b-97ea-08de72ea504f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|61400799027|82310400026|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UW5kU3lNTXBQRytOUlhkc3FSU2VvcjhaNWpWLzliVTU3WHBjbktHbEV0UGtj?=
 =?utf-8?B?VmYxOFRuQ2phWkJrSkRhdEJibzhUaDJscmhvR3J4TFQrQU5nMmREUFNxM0pU?=
 =?utf-8?B?aGdQdjFwVXNxZzNCZUR6SFZXQkRBUW1NYktWSFY3TkxQTEZhcU5uclhDbnVz?=
 =?utf-8?B?SzQ4bHdBbkF4dWxwTlQwQWZibE41YytwV01kQkx5TFN2YUMwRVF1dFByMVZa?=
 =?utf-8?B?MjY5Tm5HTUh4K3A1bGZrOUNKdlZ6QmxxWG1kNzIyQzA5d1gvVXN5Z0JBWElJ?=
 =?utf-8?B?L2NxcXNhK2FDMC9uaXJqaWJycHREdys1bk5SK1FjMXljMzcxNStrYzcxRi9r?=
 =?utf-8?B?K2FobnJlcllUdy92SVhVeU9pQWxoeHBHbmtjN0YwdGRGcUVBYVVtZTNsQjZQ?=
 =?utf-8?B?Lzc4NmtuQzllTHZkbUJEQjM3eG01dE5TenFPeVhYajNlRSs1RkZ1Q2tVTzg1?=
 =?utf-8?B?aVd6S2xiWTJ2WDhpM1Z4YTF2YzRWdFBUWnYvZ2lBaWo0cE1KeS9wYkVHemVi?=
 =?utf-8?B?OVIvWFFYeVhvNVZkMFJxQUpjRUw0cmErb0lBTzlvSFFUUTh0LzJuSjNGZjBj?=
 =?utf-8?B?a3dQUVBVdkxOdFJhSlFzbVUzT0hwMEsrYUljU21yMDUrK3ZOc2hqSjdwcGh5?=
 =?utf-8?B?MVlLNU81cHQ3RU5Zbmhrd3hPQ3NQb1QvMzN0RzJ2Q3doaW54R1p3ZHBHSDY4?=
 =?utf-8?B?WXJnSkdOVE9yUzFBaU5KaVlITjRIdHhDcTNVOEFESVFoWlZ2MUd0bHpvS3E1?=
 =?utf-8?B?dWs1US9VOXp1VE5STWhRN3g2a0g2cnF0TXdEVWlKSUFOOG1Ra0hsYkR6RFFB?=
 =?utf-8?B?RzdCb1p0OGZwbmMwQjhQYjdkRlZUZjlPV0JvOElqaXI0RHBJenBFcXFPY2VV?=
 =?utf-8?B?dldHU0FEU0hzODVLVjdVOHFacWt5Z3A2OGhFMFZINUJiaml2YUF6anJ2SUhw?=
 =?utf-8?B?Zm95ZzdERm1qd1RaR0lGeHBaMWxTKzFiQ3lFK0ROUjRtWDE4bS9HdzN0WUlX?=
 =?utf-8?B?TEpweGJaOWI3MjBOcENmMzBJVldlNWVvRnozL0N0d1lVTFM3eElWa3J4dy9t?=
 =?utf-8?B?L2gzdFN4aVgxZTBPdVlYM2loS2pyWHFqeUFaWHp1QmppZHdvdHFRUUlyUUI5?=
 =?utf-8?B?WEt0WndwbnV5eklHQVB2NExWeG9pM3pNWE12cU9CaU45bXY2MDBMZEd6bGZG?=
 =?utf-8?B?c0VoRndCMm1QZXlpKzBQUHNycmR3ZTFuV3gwUEJvZFJzdnd1STYrWHd4ZXR1?=
 =?utf-8?B?a00rNHhicW9FR2tid3FHaGd1a1JDbmE5cnJVOTdsY1QrMnFWaDhwTGtIM1ly?=
 =?utf-8?B?TCtXMGZybUEzc3l5bWtCdkd4anN4eEk2a3RMMUppQlZPNStwcGhENzUrTFdm?=
 =?utf-8?B?OFpGM2F6RUpRVFFzaHF5VkpSK0xVUFVzNXY4MUIvMmVyank0dllQWjZoMjVF?=
 =?utf-8?B?SThqamJWWFJTUSs5TGM4aFo4OUR4UmIvVkx5WmdNRFpmL3BOSTJHd3VHS0FW?=
 =?utf-8?B?QTJkYWxhVUxCcEV2cEZRaXpiSEZRNEt2ek5PalliZ2NvVW5HK25jSW5uVGM5?=
 =?utf-8?B?dy9EYUR5NUFKV1B0dFRvQXNyOUNrNlpEeWdDTHlPQ0o4QTFHT28vY0FlQWda?=
 =?utf-8?B?VG9sY3JENmN0aERCQTdSNzBaa0Z5RGtWLzdNNms0STFFTkJJYWhmOVZHU3ZC?=
 =?utf-8?B?dDNtVVpSWHNJRk82NDFyZTFoNWxDeGRzcjJUN1JTTzQzcUxTelNEWS9NQjYx?=
 =?utf-8?B?azB6UTQwbVNxMWxNWVhlcnFQcWlNMjlkSzhnbWRQRXd3T1ltck5Rc2o1SDhh?=
 =?utf-8?B?MW9Ma3VtcXR0cmV1ci9xVWR0Qlp6bjlmVHZwcXNoaURCaW9PWnhGdlEycXcr?=
 =?utf-8?B?V3FFM3ovMmY4MmFhOHJSbWlVcE0yVEhGMVZXcm9KM0dKOXlZUjdRYmtadTNE?=
 =?utf-8?B?UE4zVDRmSG0rTlRVcTRDN1NDZGx0Lzk4YWl5OUg1MTRod20ydGhjSmNMNXN2?=
 =?utf-8?B?Tmh6WW9VVEVoMmdCbnA5TzZ4VHovV1dLQk1hSzEwbndSRmhwdEF3d3pzbEFR?=
 =?utf-8?B?aTg5TUF1V3BCTW5FVUhaTlRYclY4cnFkSlFCRWpVMTJjakpxcUFHK21rVkoy?=
 =?utf-8?B?N0tZaWFpaU1uV2NMM1k3a3ZIb1h3QlIyNnkzQ1c5NUkreDhJeDMxeFN0emd0?=
 =?utf-8?B?cnQwTTd4aXFxM1pQY0VERVhHUDVLT2dqL0MzSG01VGZEV1ZWaUNTOUFiUzFr?=
 =?utf-8?B?b0N5QU1wZkpHbmlhZFpJVkNJTXh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(61400799027)(82310400026)(54012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pwBsnEsmlNoFgMzxi++lqFIiVqOIlNyEd0JCKduvsTJRm4arZhOLc5RcygL45eyXtksvHRwMpIUinG1MQ07no0A2JjtfGy6uPfidBTnTZiUTwTbLa9DAaNoQdHS8XW1hTkmXCEnkONf+K99+wE1aK147bgaWOkFHF0BQ/WctUZhYetPMdhxI4c3jOQXUHPrn+eS5A67vposx2LdWsDds4Mjujuy1jEHDZKSWZNfSrD6HnSFnd+MzURAA/KcMEFZ88Lh1+uMxPyIH4qYTM2ZMv621iNQqW6qpHlpji4oX0Gt69vR4BR/ZD6QmchEntSwHgvIdvnzzBHTZPAax5DIjsd/d0wsAm4rhlUrgvWoWgCf9djlRD/6iyA5yqxIwKKEPb84xCqkvz1Ga2VYZsy5lXcTFv/Gd3PTDLf8w8y2SAq4HmNqZ4qmWegxr9478lwjq
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:46:22.6355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac4678c-1560-442b-97ea-08de72ea504f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7907
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEyNiBTYWx0ZWRfXyCMlf7t8rYlg
 DLRS1q9PhzhDtS7l7rvVl0V/17TKlDeYT7C11G2tXTQ1xEISGmYU2lyA1hL2zIYMTW2FsDVtYBs
 db8twlt3SILD3A0SeKpp9iAzDdYFAmaxB571Bd90Ho8D6Tu40MHSLoDqFkyeNwF5JBeXxT+PivU
 IEU2kONBGlsOZ7tZZnpFOZKgO1yYrVVBl3WeMvKoMwoqW439Bf4lgVTuB0NvSrTowfLbCYivvb+
 ut5+w1/hiO+ymGRWGOra0JzDDw2Qr6ufJgfnMXChqg9G5lZO30yWFfW8fiGw5HsOCjcuMHfKb2R
 Bd7prl2fPMwma0aFXTxHR/xZ2DVVYkz+iIJRtshUqFCyt9+gFkxF9F9J0e4ao2AEXuIJUVDmOcB
 25Ji1jhlvoeKLYK0J9fezNP01+zG2WGEwEfsLkNryMc7q+MTX/isQaM5psbe8I5ntchUUBM1bba
 lcPLaNGUtc3NRlj1lyw==
X-Authority-Analysis: v=2.4 cv=Q/7fIo2a c=1 sm=1 tr=0 ts=699c6843 cx=c_pps
 a=A0XUNoO2kYPMKlNirmUWng==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=YB9ClUrNOBteZZ6JulMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: 22s1mDYwmQBhn-pPS4eSMvQTfmhlrDgq
X-Proofpoint-ORIG-GUID: 22s1mDYwmQBhn-pPS4eSMvQTfmhlrDgq
X-Proofpoint-Spam-Reason: safe

On 23/02/2026 2:07 pm, Ben Dooks wrote:
> On 23/02/2026 10:51, Ben Dooks wrote:
>> Currently trying to run "make C=2" on the current upstream kernel using
>> arm64 build and getting sparse processes hanging using 100% cpu and one
>> with other 14minutes on the cpu.
>>
>> sparse checkout is 37156835e3d725b6d750f000be33ba3814bb2310
>>
>> kernel checkout is based on v7.0-rc1 
>> 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f with some warning fixes on.
>>
>> I've not yet tried a non-arm64 build or removing my warning fixes.
>>
>> Attached my linux kenrel config just in case that's useful.
> 
> So currently it seems to be hanging when checking drivers/clk/clk.c
> doing the following.
> 
> $ make C=1 drivers/clk/clk.o
> 
> This is working under v6.19 and not under v7.0-rc1
> 
> The git bisect is pointing to this commit
> 
> commit e19e1b480ac73c3e62ffebbca1174f0f511f43e7
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Feb 21 16:14:11 2026 -0800
> 
>      add default_gfp() helper macro and use it in the new *alloc_obj() 
> helpers
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
> commit/?id=e19e1b480ac73c3e62ffebbca1174f0f511f43e7
>

I'm getting something similar with an x86_64 build and 7.0-rc1:

> drivers/clk/clk.c:5551:26: error: Expected ) in function call
> drivers/clk/clk.c:5551:26: error: got ,
> drivers/clk/clk.c:5551:26: error: Expected ) in function call
> drivers/clk/clk.c:5551:26: error: got ,
> drivers/clk/clk.c:4124:15: error: undefined identifier '_res'
> drivers/clk/clk.c:4124:15: error: undefined identifier '__VA_OPT__'
> drivers/clk/clk.c:4124:15: error: undefined identifier '_res'

I get a massive amount of these error messages over many files.
For me it's hanging in a different part of the build.

fs/ext4/super.c:4881:9: error: undefined identifier '__VA_OPT__'
fs/ext4/super.c:4881:9: error: undefined identifier '_res'
fs/ext4/super.c:4881:9: error: undefined identifier '_res'
fs/ext4/super.c:4881:9: error: too many errors
   AR      fs/ext4/built-in.a
   AR      fs/built-in.a

