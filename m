Received: from mail-oo1-f59.google.com (mail-oo1-f59.google.com [209.85.161.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0B63C01
	for <linux-sparse@vger.kernel.org>; Thu, 29 May 2025 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499181; cv=none; b=jZwx+HED5p1KZm+l7BU/n5Z8AfX/YKThGWCOGJMeh54r/p461IPwNLhI0fHelQoJXmxHsuNok0rHxEhrXN2O436WcgW7VEFGFuDWoqlPzVMafde0iWKNTbJP+/yOny6hnIibczHx5gr9SBVX8mhe5iqnPXTwR1CwhKDN7t6DLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499181; c=relaxed/simple;
	bh=e4M8URB6UTFdtC/9h3URv/5IvUb2w5I9sJ2NtfJpcYQ=;
	h=Date:From:To:Cc:Message-Id:Subject:MIME-Version:Content-Type; b=k84RxdsvPi673zIucfhv/Gu48+6/86UNeaqw3zlfd5flFyHv2ePys2FX+mc2AlcClXlxHDSPXtGDX74uWB5wkDF8Janoon+O8VfGfOe4uAB04ogxySPvvjYRbi2+ceeVGafS5ouxfGAFu8dyLnHjxX7be0DzNU6aWxKt+vIlgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancd.us; spf=none smtp.mailfrom=ancd.us; dkim=pass (2048-bit key) header.d=ancd-us.20230601.gappssmtp.com header.i=@ancd-us.20230601.gappssmtp.com header.b=NqvVKfJN; arc=none smtp.client-ip=209.85.161.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancd.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ancd.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ancd-us.20230601.gappssmtp.com header.i=@ancd-us.20230601.gappssmtp.com header.b="NqvVKfJN"
Received: by mail-oo1-f59.google.com with SMTP id 006d021491bc7-60bad055108so488395eaf.1
        for <linux-sparse@vger.kernel.org>; Wed, 28 May 2025 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ancd-us.20230601.gappssmtp.com; s=20230601; t=1748499179; x=1749103979; darn=vger.kernel.org;
        h=mime-version:subject:message-id:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXv+s8ox6hcAutw1/GW6lc+HHbm+saRgVf7+OD4ofZo=;
        b=NqvVKfJNYX1THG6f+7aD+yA7EHjsZ3+9VruI+TAX7RJkcG7t6Mc6uM7ACUmfYu1482
         kTVMt6nSsDtDXKKihbtiv46aSg6hJSma/OmE126ios1xjCTcI+jFyuNa8xm06V/i7CTG
         Rq/b6ZCMn2+9MfwxtjSXNI7TIqFo7OD/8I56DBqrogvu6OosZR2F5aiP0+a0EcROEADn
         rXrvkpeY7Jqfk4T6D+GQe7ZC+o6ZGA4slmhivXd+zA64F1Pq260F9dTBzIz4d9B1qCJU
         n8qumnIOOJ3qX+FxjlMhaNYA15YfJamXHwqyxoH32H6TeMRsrW+pJv+BBtkmCalK6uAk
         d0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748499179; x=1749103979;
        h=mime-version:subject:message-id:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXv+s8ox6hcAutw1/GW6lc+HHbm+saRgVf7+OD4ofZo=;
        b=mnhC9am8D5pZr/noGT11MJhgU859pXFgtXPiR7c9TRrB3TNuvu+IJqt6h0AEJHOcMT
         VVyFBdTUpE8h0JG1EgfnyEwMZ+0YBOUGClbh+FnHiGbjMdXEkIFKJ+No/EqFgLo5NXTM
         y6M3NtcCjtXmolZPE3Nuw/HOCOCfcMkqf7DouRWb7rul1wtuCwCSKRmWsA53CbwBIpE4
         UoSddIlbAn+GCV/Cz+8CGY7T7E8RhViSrvkvUiH+AjATDX3sjykEkLGS1CtrS23SE67Z
         fo7meNz99Uq64G21/Cj/nKthzZ4oqL7qRDkNhxDe1UCB1uVG5colth2MAJ/HIpCr5Sr4
         4e2w==
X-Forwarded-Encrypted: i=1; AJvYcCW9e+BObMfRI2R061L1jGrI9rrYayzsHM9B5miA7RNP9BbpKVzLWZzTH7deXzn1qSXuICjyGvRcjPu4jLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8acT8yLiko7t+n4dSyi/oVrf7SWL2aHSouusH5Xr08oFysKUW
	MMyIfPr3+NjFbtlQwtrarYfFKnlff63fXiuH/SBEhqlWN3U9FjQFZGHWAap1b7PmbJ5T2L44GpJ
	q2cQ/AU9XUuYygA==
X-Google-Smtp-Source: AGHT+IGOyDVqw/WYuB29GwddScmwBfOM3dPe/6j+z0EImWJ76A/tD2vQoj5ZJzdpzUGrffRp82Y8cK9psg==
X-Received: by 2002:a05:6808:4c81:b0:404:e2fe:ee91 with SMTP id 5614622812f47-40670742d59mr529891b6e.8.1748499179006;
        Wed, 28 May 2025 23:12:59 -0700 (PDT)
X-Google-Already-Archived: Yes
X-Google-Already-Archived-Group-Id: b7f2e0059d
X-Google-Doc-Id: 3d1a1ccdf363
X-Google-Thread-Id: 3aa39a2dcb2f6049
X-Google-Message-Url: http://groups.google.com/a/ancd.us/group/tarkanberenger/msg/3d1a1ccdf363
X-Google-Thread-Url: http://groups.google.com/a/ancd.us/group/tarkanberenger/t/3aa39a2dcb2f6049
X-Google-Web-Client: true
Date: Wed, 28 May 2025 23:12:58 -0700 (PDT)
From: Email marketing software <tarkanberenger@ancd.us>
To: Email marketing software <tarkanberenger@ancd.us>
Cc: s.choudhary@sheffield.ac.uk, laura@baxterflaming.com,
	Crewwriterlily@capilanocourier.com, marijasmederevac@imsi.rs,
	john_slater@ajg.com, oldbrewery@youngs.co.uk,
	Info@tenvouscancercare.org.uk, N.Wint@Swansea.ac.uk,
	sree_kala_nair@ssus.ac.in, admin@brookfieldhealth.co.nz,
	jasmijnkok@nina.care, linux-sparse@vger.kernel.org,
	wds-info@wifo.ac.at, shelley.raveendran1@nhs.net,
	gdpr@sqdigital.co.uk, Jordan.heys@cowgills.co.uk,
	Bernard.Schneuwly@unige.ch, secretary@westhouseprep.com,
	customerservice@cpp.ca, gavin@huddersfieldbid.co.uk,
	msandone@pvsd.org,  <mlazzara@stpeteedc.com>
Message-Id: <983b0c13-2488-4e95-9dbd-95b493414597n@ancd.us>
Subject: =?UTF-8?Q?Automated_Bulk_email_sending_sof?=
 =?UTF-8?Q?tware:_http_protocol,Fully_Autom?=
 =?UTF-8?Q?ated,_High-speed,_Bulk,_Multi-th?=
 =?UTF-8?Q?readed,__Built-in_Proxies=EF=BC=8E__=EF=BC=8E_=EF=BC=8E2?=
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1138776_1457139099.1748499178578"

------=_Part_1138776_1457139099.1748499178578
Content-Type: multipart/alternative; 
	boundary="----=_Part_1138777_694179960.1748499178578"

------=_Part_1138777_694179960.1748499178578
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



=E2=97=8F Thousands to hundreds of thousands of emails sent per day.

SITE: shorturl.at/u8Mtr
TG:  wowofrom2008

------=_Part_1138777_694179960.1748499178578
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<p>=E2=97=8F Thousands to hundreds of thousands of emails sent per day.</p>=
<p>SITE: shorturl.at/u8Mtr<br />TG:&nbsp; wowofrom2008</p>
------=_Part_1138777_694179960.1748499178578--

------=_Part_1138776_1457139099.1748499178578--
