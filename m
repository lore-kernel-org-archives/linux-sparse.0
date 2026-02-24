Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0824E4AF
	for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936974; cv=fail; b=OxdY/1YJsKt1FPtFJYTG8zS7X5LmN6OFjFkDzx7+NKdn0iQVeKtjT3FtHcd5RhA2DFfSerc8P1hKjl8cJw1ZV6wyF0xgva6ZJyTrvnAvee4/iwuBkNBIneMPyaY2H1COKDlhKfhMCilvxh1rT6teQmsM9R3RBEGa0MjONMdoqaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936974; c=relaxed/simple;
	bh=RCKMc7iTLz0zK3XWQNEjDxp2eAZ3kFiAuFUiX+kjw9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcFALSQHttruz21m8ibjMmwqKbPnn+ExWxFQievnQOo97995LZhcwyOez0GJFNDksLR7wrd2Lzsn4KapBrzQIpUnapIyM7gdpjpH8BCmfjQ/yMINpUDgbSIxwc7i8g1QB0/nsAqbHfp2zV0+QLMixykPNyWwnX3TC1Dkca7aufs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FQ+gdgCX; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=jyMc3dO5; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FQ+gdgCX";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="jyMc3dO5"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O6pqeK3513219;
	Tue, 24 Feb 2026 06:42:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=7axZ/R1Jc2T4FyeH8WBT563kOiE9iHoD1PjYRDqml4Q=; b=
	FQ+gdgCXW5Og1MoKE31feAeULxhOp4JxccpOHMQZYdaNmx+WaOJxgQj7im5gvQTQ
	BgUWEZWqvP7RWibprVqY+cqxy8FMyLnFXCIr2YaXoby4CMEc8XQh5xQtqASo1Qpc
	Qdr6mjO/Os9p2ZE1gW2WMD7B7SpNTpVZXgWeh55q4XbWCiUtera42e8A3Yz2USyy
	dkiGzdXLSvt14FMPP7FLq55xUK1B0EnEG/qLd+FEcCLEwCkDQ+ASIVkjfbZcgGB5
	JkN8IriKxx26SfdCjNCgvYAxHqSuwBx+CVJBm6mTMUEeXApVdtvunQEK3dT6RB//
	But9V/qishdRb+tpPvoUeQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020101.outbound.protection.outlook.com [52.101.61.101])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4cfb01ask1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 06:42:26 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+EpHedRtqQfKbk4LArAZXqINv2bgG3sRVuiGOcbwQ8qb2ac5Q9TkLpeIqPs+ZJYrqmis2n8bMIxllqUKv2TV3kPB55wgPOsEJ1OeyPLNfHNullm8UcjTX5DIax1VEd6UbUJORlC1/bYGvLqj9f6A2qPNEGikZgdoyn0TwwfWYYiXGGm2nBRN7MI/SXYDUQAdU2sb5t8RzJ1ElipOHHbQhukUjTn9zkbvQosqRPRNaTFCHUjXX3/na8fOROHXUu1r5981wmGHthF0DDikQQNka5S2UyVefRZX0emhQ/adxsEA1YhoK6LoO0Abpmejyn7LwRCsZzNGT93bOWUb3dRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7axZ/R1Jc2T4FyeH8WBT563kOiE9iHoD1PjYRDqml4Q=;
 b=AzbBdzOnflAvRvRD+HkzbOgixay4rGy28WGq8QvxM0H2pXc1jg/BVtp8SklKhK0aINT7GX14ph/5Uvz/TDPw1OYoRgXLBFYibQJRfRjBB19ctf+Tyy0KLcoF6ieMOJ7uxg9Rt8DzvGj2ZrjouSTm6sLy1959tlwGulTIawBBda0b+mk39kyGmsTZnOq9t7JSDC+XJUGiwmouoefufsGF9IWCSGiKRmuhJmZCkb3dxZrmggEDgTJ3ZmhkwmJG+W/Eir01d3kox4QQ+ldMbnPJDWA4/Lqskojg+h67oKVCzA8ZVm+Gd1dbeAsofm+Wo5naFs/d2xfn8gO6GbhQ1+VwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=chromium.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7axZ/R1Jc2T4FyeH8WBT563kOiE9iHoD1PjYRDqml4Q=;
 b=jyMc3dO5TgeCG8mD7pzig+Ozs8yw0ZV+jfRLGDdsR7WMd9SSMsm7G4i88TStVSZDAJY60XYW88vxJTIbJqzU3pLasxis4POtYuJVt+WJFNzF5HuCNyrcAzz7WJvuPdlhbct4RUDCxOJZ7kDKBtpvzGILNAM8Yiq+zwiEuRkz6cs=
Received: from PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::8)
 by SA6PR19MB8720.namprd19.prod.outlook.com (2603:10b6:806:40c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Tue, 24 Feb
 2026 12:42:21 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::f3) by PH5P220CA0001.outlook.office365.com
 (2603:10b6:510:34a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 12:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Tue, 24 Feb 2026 12:42:21 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 884E4406540;
	Tue, 24 Feb 2026 12:42:19 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 722C582024B;
	Tue, 24 Feb 2026 12:42:19 +0000 (UTC)
Message-ID: <45fa5433-c95d-44ca-a072-fe31575724b3@opensource.cirrus.com>
Date: Tue, 24 Feb 2026 12:42:19 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse: add support for __VA_OPT__
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org, Chris Li <chriscli@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
References: <cover.1771930766.git.dan.carpenter@linaro.org>
 <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
 <29424a96-4c7c-4076-99bc-903cd857f89a@codethink.co.uk>
 <aZ2R8k1MRiPwJwOC@stanley.mountain>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <aZ2R8k1MRiPwJwOC@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA6PR19MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: b8480c83-f226-42a6-f7c9-08de73a2273a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027|7142099003|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEp2dS8vNE4xTVptWEZIcHkvN3V3ZnhYRFFMM2Q4WHRlc25LaVpTa2p3d09h?=
 =?utf-8?B?d08xem1YV0RhcjFIdVZkZmpTVm9seS9GMXpwYy9CMjVjS2J0NFc4Ui84Vmta?=
 =?utf-8?B?cmVkeC9DVWtwek51NHUzZ0RmTEdvY1BNRms5ME5QUDNmT2hycTZVSUhhbTRw?=
 =?utf-8?B?L21Hdlg0VTB3SFZzWnFjTE9mYTR6ZkpGbzRseEREcnB6UmpVQmhyditLOUNQ?=
 =?utf-8?B?VWJ5VEVmQ1ZZaWRPN2piV1FZZXQ2M1ZQZHdXdDlOY2xYRWIxRWgycVkyQ25q?=
 =?utf-8?B?VVZNVTlEKzNBTEFlc2c5YW5EY0xTNWJDWEVETzlHTDhmbE1wSHB1WDVDNTJ5?=
 =?utf-8?B?RVprVlRXNlFKZUZyMCtybUIrZi9JY0M1U2p5a1pqSTZST3hWNWdmem5PL2tE?=
 =?utf-8?B?eDZlL25nUjJRUGprTHB3VUJlcDFUTmZaZnM5UmNaVmlLNVVGV255SitjVUhT?=
 =?utf-8?B?cWgwRVk1NFlxY3lUTDFZTW5RdmFDdzNUT0xlWklZazdlZWp4VTUrM29VbmFx?=
 =?utf-8?B?SmZ3QW4wTVdOWFB4L0VURlFZek1FWTRvNmk3Mzk0WU1JdElCVEFkU1dPdlJp?=
 =?utf-8?B?UU5CNzNPRytHOXFuTmduSzJtWktCMVdyMUNrUFREVXYzVUVkb3FYNnFwb0VC?=
 =?utf-8?B?K1VWc0ZoVXJvQ1hta09ibVZjeWlXbjFzQmdpcTF3NDBlWjNmWXA5TFNtUmox?=
 =?utf-8?B?TS92Q2hQZnFXYUtBWDE1WmczUlNMMzU4NmdyZUhBd3dRUFByeE54YXQ0bHRu?=
 =?utf-8?B?bTZPczBVWWExRldvVVpITjlqVlRLUURUaUhNc2tDUGgwd1ZLdEVNaXNNMVBD?=
 =?utf-8?B?aWx5YkZPM1lFSmMyMFI2RHV3NDdDT2Flc0E5Ly9BT2p5VDNET2pPWUFlb1RJ?=
 =?utf-8?B?eDRwaHNzcGk4Q2RVMmVaQlhVbHZjZElrZFRGeEpOeVBFa2Zkd0VMU2ladmFq?=
 =?utf-8?B?WDFOK040eFEweW15ZFE0dEIyMm1wNEpnSm5RMEU2ZFJpcHRlVldYL2tLZERV?=
 =?utf-8?B?WVU3WnRJUCtRWTUxUHBXbExhTXQzK3Q2TVd2VEJPUzRieDliRm01WXpYcnVE?=
 =?utf-8?B?VmFqaUFhdGdMZ21EUUc5UXpQaG81MGVpL1ZsTyt0Nld4cDhZYkV3dm1DNHRJ?=
 =?utf-8?B?bXF3eUhLdkVzUGZIMWhLRTFMODRIVEVxUzVLZUd5VmQ4ZHM3YlpRRys1K1Nv?=
 =?utf-8?B?VmJ2Vk4yOFh4R0lqSjV3Sk0xY1V0TExwZHNvN2pGYXRJS1Q5QU14ZUF1T01T?=
 =?utf-8?B?VlRoMmR3anJLd3o1eGFBWEtmMzZCYXd4L0JYcVMwOSswYklsMWlCYlo2enE0?=
 =?utf-8?B?OVlYcXdIUmpkbm1VeXJNTzEwZDQxa3Z1bmhBeVo5V28yYlI1MnpvUjhJTTlu?=
 =?utf-8?B?QWhNZkgvL1pIYXlRYVEzRGFybDk0dEozaUMyVHFONlJ0ODNYbW9YZnlNUWs1?=
 =?utf-8?B?VThEdm9QeGlWSit3RVNocmVqWDJSVmdzNnYyYWMzSHBsNDNzQm1oUUhQOGs0?=
 =?utf-8?B?Mmdzc2VPcWtMSEltRUdsWTlBcVozaXp4MzcyN0JpbUxOMUZjcjJxdCtRSU90?=
 =?utf-8?B?dUFKVDcrcjlPZE5qQ3cxR21aR05OdzI1UmFHbjRBVDM5S3hJRVhidkpnZFo3?=
 =?utf-8?B?WVZ0bk9ncTZhbXBjZnBMRDBFVTd5d1RHek5XTUREUnREZXVFQVRoVjJIaEVO?=
 =?utf-8?B?eGxsanFwUVRPS050Ykg0ODE4Y1paVXUvaWtvV0tOdXYzcGo3c1VWVWVzS3dB?=
 =?utf-8?B?Y0NnUGxDQ0JVZWxXbzZtV2syWlNyQ1NxcjBKRUJMUjZJMGlSNDErbmZPK0wr?=
 =?utf-8?B?SzV5Vk5HWmw2dWh2TWNoOEJCZFR0SVo0a1ErTEEvTFREekxoNTFvZjJ4Smh4?=
 =?utf-8?B?a3N0UWVJNkNjekxXQmdibjIyamxGeS9uTjlXV2E4Ty82TC93UDFnSGdxdDRz?=
 =?utf-8?B?aEhYNEhjaXN0Q0t5YmFSSkhCbk81d2s0cWhGcXpkdEYxMGlvN01aK2h6bmgr?=
 =?utf-8?B?SWxoODdGaE11RUtFbUFlTnltUnpXTm5wamZsYkpRN3VVQWlJUWpBL3RCUkpX?=
 =?utf-8?B?bWZuanFIRlBFb0ZNNkhlbDJYV0w4bUw5eitmYWozWUV0UnBEVG9qMlo3a2VY?=
 =?utf-8?B?dXRwM3E4VkVRYlN3RERjK1IyRXl4R3VyRGZCQlNUQnZQclg3M2NuNkN0dkJP?=
 =?utf-8?B?QklvSWM0ZENsOEJzYkdmRWZMTTFVN2h1NmtmVlQyeklodXlncnBzNVNOZnRY?=
 =?utf-8?B?S3NBaEE3MTVxUDVycEE1ekZ3UklBPT0=?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027)(7142099003)(54012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kP5zZnwo2apagMevMYrNiSQLP6nDY93xMx+EO6i9lxYq85X/SYQhIo75H3BfEL5btau/0aQ34zzl08THExBMle3p5tin5NmzALbb9yq6q60ifdvrWmRYOczijP5xaQo28u03CD4zXDJudX23rFC7D3j3PDikwJKFT+t9z+2JMoQsZZwdH3cpbJM+tbKytUFS2tfhc+2losAFlB3TCDdbgAkj+cNnngfKvX4Sg7Nuhm2Kf92zjjtaf/eWrKM0H9eyzpOS12E/NIppIW1f/vpdbTEBypyvfqUvpvKoruNj4iVryVt4JJi4lKaM8ar0PPQ5hOgPvqY9Ex8pa0ZzmYwhGAWboEIsAsGibNETHE/cOTf24oGTA9mKZX16xqGmd0vjjn9FmfEx1tswiSteENqHZB/PzE80SBWXBMAX38volrqMNag4dxCarRWTco/Ewqwm
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:42:21.0425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8480c83-f226-42a6-f7c9-08de73a2273a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR19MB8720
X-Proofpoint-ORIG-GUID: _4YZ3K7NLXmr3qbQBSYE5O4P5gI-iSNn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEwMyBTYWx0ZWRfX+jnHBddTehhH
 MF1JUngTXEqzp1e3HOZAcOyEi6RAwaDBeMIznVUwv6O7nPtfb8+Gz62Sa8q6tV2p6MTb3xiLpqs
 SUZcVssa6sHYVxek29v6RrGHrWZUkw9Mli8OuYgpuUPkE7DYbKerfXYlzPmR6ITh25mDsJh3KLS
 UwJJl7Td3848p3P/9Ark/YHffM4940ihYt3szagJNAYK7aX7S9+8btX0+5xB1NjCh4diI7D7bie
 w8zBFVU+DBV+uLYozTxDa9oJfOJ3zn05xaC/ZCdHGHS5ESOIZOfOJyAyI7r/xxl4qgYUyHGRF1u
 XdLJ2wMeWZEMmN8rWufzzU99OXY96EItc98Kk7281b6hPBRrnHwXTdKIB1N3DOODkJugikmYv6R
 CYXXksQ7kCk8nQiTI2sIngp2MnfAsgdmMtC2Z5YhwJA78+cJVLVqqo87a+Thp121wJ3idwGdrTQ
 Hm2cYQumW7ikfYc96pQ==
X-Authority-Analysis: v=2.4 cv=V99wEOni c=1 sm=1 tr=0 ts=699d9cb2 cx=c_pps
 a=ONVPZRIUl3/knk75a7oMmQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=w1d2syhTAAAA:8 a=TCj0F5cred2woa2VdOUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _4YZ3K7NLXmr3qbQBSYE5O4P5gI-iSNn
X-Proofpoint-Spam-Reason: safe

On 24/02/2026 11:56 am, Dan Carpenter wrote:
> Oh, sorry, Al's branch changed that code more than I imagined.  I would
> resend the patch, but I need to figure out this GCC warning...
> 
>    CC      pre-process.o
> pre-process.c: In function ‘substitute’:
> pre-process.c:785:16: warning: function may return address of local variable [-Wreturn-local-addr]
>    785 |         return list;
>        |                ^~~~
> pre-process.c:687:31: note: declared here
>    687 |                 struct token *added, *arg;
>        |                               ^~~~~
> 
> Anyway, here is what I've forward ported.
> 
> regards,
> dan carpenter
>

Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>

