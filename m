Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AB42AB1
	for <linux-sparse@vger.kernel.org>; Thu, 17 Oct 2024 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156149; cv=fail; b=Toynj014MdS0ij+Czxfyz43aaUu8k/nSE57JTBIKVDzYT7tzvI9RjedjwDHzINlx01TGEqmGZtym8heWzO9GUVQbpr7rCeSSE+QWF2Ah7X8hFDQGZWcH++lSW6+WnHe8dqrI6MpIqri5c9Rg6czsv/BNVhLZTDKoGkekLTwaxps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156149; c=relaxed/simple;
	bh=5CB4GxGqt5MblXoIE6EJW07ApKs7reBKtxRCHBnhklo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V4gb7wFq9JrzwCChJ2jRCcFhYaoHyM1DgfRN/RzTh0fW1j3++8UmiyxkWYww2tWCu+R4HLwvq5G6EWqKi+Kw5WXWcKGUmTourB5IJIuhathouSnonojRg7h5cWaiiuBnD3e4VFzZF9NoyRvCqQT9Evi7Dy+if7+EXAb+hK9hA5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A9Wdg2bT; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A9Wdg2bT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4FYfbzDkLAMp/21TM0l32sIQCi+4k5OoFQH7AgJ7/dRF5GrBOniXQAEF+a9vfKRSbPRUgNulVnf046YwLWjANQXkfkbTRMzGqBRjOzhAde4nXW7AR/V/xx/utiuO1gxapD0pzpi8d3jKgPKr0qU+MgyUrZysrclvI6+iWq3N3h8JLClOebze4OfcVinR6Bk4hz31cYxPzL9vtO+6TwdouVaF9ge9XRI2W4JW821G7LL41QOYNRHSYjaPtV4dDthSDJLkxCLMZbcph+qxdPq9czZA0BCGuQul7PcMbt7jtB1uT6/b4iMdj7m3qOhg1bwFRd8z7ys473RJPKsywPWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CB4GxGqt5MblXoIE6EJW07ApKs7reBKtxRCHBnhklo=;
 b=XUXpCbZwDG6Ew8DvmpeydM3chfpEVxZlUxTuLJKG641ApazFDQokyG6eA56gRnxZktKZyllYgh7G8df8Mmw400mtmlxDRvDxMvHBSyTSIE5AvTJvUcyCPbKG5iNuxEcsyGxdyi06ikyqkyXf6YBbHrQ/C/SHo8UYIPSnFOwxw4/t9k+glaVaipeJehHlrjKRZcTPl2f7NdPuYEZtIOZrmJMz0yu38LAtaMlDLFF3eT/zpuPxYJwVY7VU6rwTYI3hpoPX70YN9vg2+LVzkVuu57jFGTiSR95wiq2jsEtTYAtxsQdC6qxFvvoWtW0kpEuidi54c2aUYy+Kx57vdIePew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CB4GxGqt5MblXoIE6EJW07ApKs7reBKtxRCHBnhklo=;
 b=A9Wdg2bTr3f6iWdxay/T6sCvkGDDNU35cN4jAcWxH3RG23/h7PBGeLmTG3l+oNEwg+QsftCdg/q+JxaTgoN1wh+lZx6OXi0+vtYv2DDpDRJWiUN+SrCTmJ3d7tSmdf0WwoV86M0zgkflFxkVK02GE12wsKC8bSh/8FzazLm0t8WsOuhd2TrxqWhFd5i0d1skVbOo+zhNQCFm9hd41gd98+ZqH7Z9IOSEnE7rJ3Br4A8nx3PTLpNN8TP2+YRq5EbHaet2jWnQA9oS1GZkKqGokx0FG2BMctgtD/Dsi4HQQcmaWh//VvkgiEegadoiMcHIRqUrm0JEUV5ZZsb8zBIAKA==
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 09:09:04 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8026.019; Thu, 17 Oct 2024
 09:09:04 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: how to figure if a struct symbol is incomplete
Thread-Topic: how to figure if a struct symbol is incomplete
Thread-Index: Adsgb8fdr2SGtUzFSdyBobkPl0QdSQ==
Date: Thu, 17 Oct 2024 09:09:04 +0000
Message-ID:
 <SJ2PR12MB8943C1A7AF702D739C892D8DA5472@SJ2PR12MB8943.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8943:EE_|SA1PR12MB8162:EE_
x-ms-office365-filtering-correlation-id: 61426592-f9ad-4d67-0215-08dcee8b593f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGJ1TFF6bG9JdXlWWGdmU3VWcDdRVm5hUnJtYlh1dzBjUHFQeUpqMEZHcWNX?=
 =?utf-8?B?MWc3K3ErWDNKZFBaMUVyMFh2Y01ZcHNDM3RhWEF5NnNLVDZzbHNHT1k4K2ZY?=
 =?utf-8?B?c2NvSDZYODJZRGdGb0tQdlNLV2xVM2p1SmFvOUlOMWxTSUhkMFVuWjJTRkFJ?=
 =?utf-8?B?WTlYNzAraW9GbW1HSy9DZy82UlBBUU54TFNOYUpGMi9ldHJJVEpzTUlMaXEx?=
 =?utf-8?B?T3d2Qk9TZGZjaTRrRkkvdUJ6VlBBUUNGTUVacjZ6NURDYVhlY24xbFRaL3ZM?=
 =?utf-8?B?OHNYMk5aWUNEQU1LR2l6K1VDYVM5ZStsYjJWdUJwM1ZRalUrYW5nYlZLTXZp?=
 =?utf-8?B?dHRhU1pCQ01HUS9XRFcwenl2dVBlTk42MllTZXJZVEowYWRQZjFVL2xYUVhY?=
 =?utf-8?B?YVVvcENRY2EwYis2ZXY0Z2tFMUIvUE81OWt1VktoRXpxZUNVdGFRYkJXMW8v?=
 =?utf-8?B?Snk5cEZpU1JGbFJtcjlrQXdlKzhKWnl0aENWMlNHYVAyUHZCVkZ6WTdnYXNF?=
 =?utf-8?B?dEdjbXRyNzA0R1M4dzVEOUlJalJEYzJ5aE9wVDFOZlh6SEZyU0JsbDl3WnZp?=
 =?utf-8?B?WUJSVDZ2bnRIS0VoMitEUEFkc0pPazNXR09QazhDbXN0czRkZE1CZ3ZQcG14?=
 =?utf-8?B?aDZLU0x6bW9QdmdsYUJkQU9mcG52YVM5WGN4TzlxVDZjVHk5bERYNXcxNE1w?=
 =?utf-8?B?NmdtdHV6NkZIei90Z3Q3OTRoWVBlb1BtL3NYSUk2TktvdHR2YkpTVFhSL0s0?=
 =?utf-8?B?STY4VjU5N2R3Q2xqZmtLSWRxbkkxZjgyUEJOZldFNFIrQmw2dWZWMGM4WUJL?=
 =?utf-8?B?bVhtZ1VvTjFsM28rZi82d09nTGlERGxXUUxpaE9rQ3dHVUJxYzRML3hwaFA4?=
 =?utf-8?B?b2FwcEhSeGEvckpXQllJRDMrZExjeldGUHV1UHZZc1VjS0xPWUJnL1AvMysy?=
 =?utf-8?B?RmxIalR3dE1pb09nWXNzeXI5WUdtd2JHQjlhdXhIcXpvNzlRZXJBa3hXcjR4?=
 =?utf-8?B?YnQ4TVZQdTBLejNOeFIvcUZsTDlub01memNSN05Yb2tOMmsvdVZuUXBlalNi?=
 =?utf-8?B?ajVlQTd5RE1ydElGaUxqN3lQUWpRaEdRTktZbm1HTXNNcHhVK3d4bE1NSU5i?=
 =?utf-8?B?Mnl2V2V4eVVaSm1mVXJiclZJUGJOaFVrdVhwR1hZU29ZKzlEcWNkY0pHd1ZX?=
 =?utf-8?B?cG9PMTRpNG4yaXJCL0s0VE5xOWR3SytpdUxnOUM4VEpyS3N5ZUgxaFNLQzQv?=
 =?utf-8?B?K0lWS2FhcWF0RmlCSm02V3BhUDh2SHpYNzNaUVRzaTFTSHVIRE44SGlrS2Na?=
 =?utf-8?B?N2p2ZEVJTnBjMk52ZDhnZVBEZEpZa1BYeUozNCtSQmd4eStxRmpWcmIxWGJP?=
 =?utf-8?B?bTlKRTQxQjNKcWdNUGprdGdsUnJ1R0xYWDBFT0NrMFRrb0duU0hLK1BOdWg1?=
 =?utf-8?B?aUdrQWQ0ZStIOTRMTE5CVU9QZVdZbEx5dzhRbzlScGN0RkZwaEpPMHZmWllQ?=
 =?utf-8?B?Tmhxb2Y2UHhGem1xNFRHaVVIUm9sTTUrRVM5Vkp6cnR2M2w1dVZuUTR0UDQw?=
 =?utf-8?B?V2gwY3VpekRyU0cxeDR5ODBoMlFoSFN0eDB5eHhneFhHTjhSRDIwdVFmREZr?=
 =?utf-8?B?clVRdVFRK0t1ajQ5eW9YM0ZQcnRaVVdKQmRBV1BYaHVNckVSbTFMRXpIT2hr?=
 =?utf-8?B?b1V4TVhERW9DRUdpM3g1eFRmSmkzRGVFclZhanFhaUwvQWZ3UUVJaElVSzVn?=
 =?utf-8?B?L05ackZDZGdsUVdNRG81bk1mY1AvYUh4RlRaQ3BRa2gvOUZybzVxUGFqRDFH?=
 =?utf-8?Q?rcVXtrvNi7DJagYICtjGUzBks+aExJv/AJZbw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEpLVXF4VGMrYXRZRDd3OGZPb1FhM2JaZmdYNGhJcjJjS041bmlHOWN0Yytj?=
 =?utf-8?B?b0tzMTVqUXNsUjF4cXJFRWJra1NYQjU4MEx6RkE3K2dMaFhvcDY5NSsvdVgz?=
 =?utf-8?B?UDR6d29mWFlNa0NURit5bU8zVm96d29ydk9Pc1ZkSFhHemY2dU9OOE9YWWt1?=
 =?utf-8?B?endFTVFhbGltQjFKSUFSdnVZWGJYQm0wQW5CZjkyb20vRzI0anYxbzg3a2tG?=
 =?utf-8?B?YWw5d2p4dU1aNVA0ZTJVRWlUY3lhbU91aUdFbTBBSXVoYWY1d285UTdEODli?=
 =?utf-8?B?ZDhab0l4UU5lcUVscUZhNFNsYTFzd3VCNHBUdE9FTUVoRTNzd05nWEZPUjZr?=
 =?utf-8?B?Y1R3dE0reXl6SzJTNThZWmZ6R1ZCNnp5T3BEbEVUc3k5K1JwQldlYlJCcVps?=
 =?utf-8?B?a2tIdXozTGhCQnczaXFFTEhobmp1M3EwczB3dUVpaFhEQ1lqVk13TzVIRllh?=
 =?utf-8?B?YmkrZ0pZVVI1L2VhS2VvM2RMSXdWK3RWby9JazVVSEJzZ2p5V25mY25PSzlK?=
 =?utf-8?B?bDQ2SnRveGlZRnNkVGFXdUliUkxGYi9ZZDhsS0lOUHB1WmZMeTczOTUvZC9N?=
 =?utf-8?B?bmY5czhnV08xTWYzMW9JNDV5M0ZVQXB2RWpXekJ3OTZEWkh6MFFuN3MrMHZ1?=
 =?utf-8?B?aWtwdGJPQ2RTQ2l6azFSUkRJN0YwZ09mdTRqU0loQWZTUERPT1hVL052L0x0?=
 =?utf-8?B?bjBaRjhBMitZS0dnaXdFeXRqRnduKzRObFI0NWg5enRGQjBNcVdrVDg4dmtq?=
 =?utf-8?B?d2I3cTRUTVFiT1FCUlpMRk9PcTM4Sk5PZmE0cXJ3QjYxY3ZTL1BndlFyTFIv?=
 =?utf-8?B?V2hXSUVEcU94RXIvNy9MVGlpNGpyVlFEc1RkcHoxc2lGZ3U5VTZpRHNNRlhP?=
 =?utf-8?B?UmpydU9WUG1DRDF1aUswS0RpOVlmS1BjYWdkakZsR1EwMmZDbWhJSVFKdmcz?=
 =?utf-8?B?N3pnc1RsaWtoRUdNZjNEZzZFRzY1WnNTSERGT0s5OVB5aW91YVRjYktEMTFN?=
 =?utf-8?B?UnNWdEJnbmorUEdxbC85ZlkxeGo4Z2swSFZvUGFNa0k2K29VbTl6VjFJWXc3?=
 =?utf-8?B?aDBacVdXNzRtL3FWVFQwK3VjeUFDNTcyZi9ldGtQbFdQVU9EQWtYQmR1dVNH?=
 =?utf-8?B?VGVDK2ZFc3ZSRXBpWjdxRkpDVGpyckt1T0N2TkorUDloLzk3OUNaL0hwKzdV?=
 =?utf-8?B?K2xQelpMcFRCN2QrbDZ4TWw5Q0E4d1BzbTRENmlmNXdnbEgrYkRLcEV1R1VH?=
 =?utf-8?B?OHhPaFk2UU9XNDcrc0E2TEtxbi96RmRXRnUzSktXUzkrK2ZOOVVwTWd0TWNj?=
 =?utf-8?B?cEJCMmxVeHJEdmhKYnVZd1JhS0NrQTRvdEoxMEhqUHZNeldiaGNOcVo5ZDAr?=
 =?utf-8?B?U3JHL1dyeGswQkNUam9PVUxOSVhFcnFBNXlhWkhjMm53SE95MzF6QmZieFZa?=
 =?utf-8?B?VFdURy9QWHNPM2FGb05GRmMwekc0RFQxWGUzZ0xLVkhSb3h5MWpieGdXa1pr?=
 =?utf-8?B?cmxBV3QxK1BwSzBRWTA4MlBTeU0vU1R6TDcyalpmS0dKdkhNcllNdVJnREZv?=
 =?utf-8?B?dTQ1V0NKQk5vN21DaHp3aXRibEx0VGZOaytXZTEzSUhMNzA1MWxNeG1RZXpK?=
 =?utf-8?B?YitFd2VneXYrUVJsOWc2WHhjVWRpaENSdmdmMTRHaGZ1bmU1N2YzVXNmdVpB?=
 =?utf-8?B?OTNYRWpEeU44OXVjbVFaeG53OTBDODVDRUd6LzdUamZLMDJrVWVFMHhqeW1h?=
 =?utf-8?B?ZTZQaWg4a1hKdis2em03cWYzc0lMLzRHY3h6bzd3OFJBZGtBMGs1amRCbUxD?=
 =?utf-8?B?cHVsbWhYdjRicFdSZElJNUFMNEYza29vdmtYZnhtbWttTlN5UDlwRzFPWEtU?=
 =?utf-8?B?T1JZM1ZUM1F4OU01OFBHY0tjWnhSWVo5dGhZOWE2cURQRlZPbDE5SnNkSTFY?=
 =?utf-8?B?aFlYMGxEeVNwYWdVc2dWcGlWVG9TL1VlbWlIdUdmL3htVDA0N0VQZHhPKzNk?=
 =?utf-8?B?bFRWaTdQSEdtKzNpQ3BwQnZLeW8zQ2FHSEpLWWRxWUt2cGRzQkllY0tKbENh?=
 =?utf-8?B?MENJcG1KQWRXTzgzay94SHJ0MS9RU1QrVk5ZY2p2ZWhrb0g0ZFdkKzYrZ1VJ?=
 =?utf-8?Q?zgZ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61426592-f9ad-4d67-0215-08dcee8b593f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 09:09:04.4636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65W0rPsJV978Wszi5I/+ENZdMU1bYtsg9JjBBGQP/4TDdzXc5VbJYj5LEiE8scaGHiPsT6ZjgJGxKEgAcy0ySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162

SGksDQoNCknigJltIHRveWluZyBhcm91bmQgd2l0aCBhIG5ldyBzcGFyc2UtYmFzZWQgcHJvZ3Jh
bSwgdHJ5aW5nIHRvIGNoZWNrIGZvciBjZXJ0YWluIHRoaW5ncyBpbiBDIHN0cnVjdHMgZGVmaW5p
dGlvbnMuDQoNCknigJl2ZSBsb29rZWQgYXJvdW5kIGF0IGV4YW1wbGVzIGFuZCBjdGFncyB3YXMg
dGhlIG1vc3QgdXNlZnVsIGFzIGl04oCZcyB1c2luZyDigJhmaWxlX3Njb3Bl4oCZIGFzIHRoZSBz
eW1ib2wgZW50cnkgcG9pbnQgaW5zdGVhZCBvZiB0aGUgc3BhcnNlKCkgcmV0dXJuIHZhbHVlLCB3
aGljaCBhbGxvd2VkIG1lIHRvIHNlZSB0aGUgQVNUIG9mIHRoZSB0eXBlcy4NCkFmdGVyIHNvbWUg
dHJpYWwgYW5kIGVycm9yLCBJJ3ZlIGZpZ3VyZWQgdGhhdCBJIGhhZCB0byBjYWxsIGV4YW1pbmVf
c3ltYm9sX3R5cGUoKSBvbiBlYWNoIHN5bWJvbCBiZWZvcmUgSSBkaXZlIGludG8gdGhlbSB0byBm
dWxseSBjb21wdXRlIHRoZSBiaXRfc2l6ZSAmIG9mZnNldCBvZiBhbGwgdGhlIHN0cnVjdCBtZW1i
ZXJzLg0KDQpXaGlsZSBkb2luZyB0aGF0LCBJJ3ZlIG5vdGljZWQgdGhhdCBJIGNhbm5vdCB0ZWxs
IGFuIGVtcHR5IHN0cnVjdHVyZSBmcm9tIGFuIGluY29tcGxldGVseSBkZWZpbmVkIG9uZS4NCkkn
ZCBsaWtlIHRvIGVyciBvdXQgaW5zdGVhZCBvZiBzaWxlbnRseSB1c2luZyBhIHNpemU9MCBzdHJ1
Y3Qgd2hlbiBJIHNlZSBhbiB1bmRlZmluZWQgdHlwZS4NCg0Kc3RydWN0IGVtcHR5IHt9Ow0Kc3Ry
dWN0IGZvbyB7DQogICAgaW50IGE7DQogICAgc3RydWN0IHVua25vd24gYjsNCn07DQoNClRoZSBz
eW1ib2wgZm9yICdzdHJ1Y3QgZW1wdHknIGFuZCB0aGUgbWVtYmVyICdiJyBib3RoIGhhdmUgYSBz
eW0tPnNpemUgPT0gMCwgYW4gZW1wdHkgc3ltLT5zeW1ib2xfbGlzdCBhbmQgYSBzeW0tPmN0eXBl
LmJhc2VfdHlwZSA9PSBOVUxMLg0KSG93IGNhbiB5b3UgdGVsbCB0aG9zZSAyIGNhc2VzIGFwYXJ0
Pw0KDQpUaGFua3MNCg0K
