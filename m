Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538A2E1F03
	for <linux-sparse@vger.kernel.org>; Sat, 13 Sep 2025 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757740043; cv=none; b=b9ARMXiEyGur2hgX1JyhXjtsDPdHotQrXkPIKy3UpxcFaj66DfJbzJ3pXU65P4MkxUfOtrns99yvjm8rIuMDPxWeU28mps3lb0ILrXZZOjm+GwOADjqmz7A00Qqbogkhc9vsmgzQf6Eqgp3crrupXkiUcXFzVHyKAjVCYdBa+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757740043; c=relaxed/simple;
	bh=+dkaA/5jekmOae8lvvUtnUz9sBHImM+xWxrfBTMgBDo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SA2ECaerSuc2l3z87bp4tJah/UeenCXMECTWfo+PhmZfr7jDOojubq1DCKVl2ZDq9lJZ/GbHsVAwM60rs+ZAjm++rKTEpxUaZ05ibouO2PUQhzKj1g3p7W2Z0llvI0+342b/J3O8p5g67LI+A2EJiLXK2/FWJsC7AYtLLjlaUG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFq2oznc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFq2oznc"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b54b55c6eabso769455a12.2
        for <linux-sparse@vger.kernel.org>; Fri, 12 Sep 2025 22:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757740041; x=1758344841; darn=vger.kernel.org;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+dkaA/5jekmOae8lvvUtnUz9sBHImM+xWxrfBTMgBDo=;
        b=MFq2oznccexTvlh5WSdlg3DkiORaaODM7aL9pYKJE7XIuf/5pmdF+9/BIhEEBH/bSs
         oSQdU2iQS5NSAVPs9DVfISF1zVU966DZWG0Xu6mRaAVRz5e2WhqO3sKLMW7UmWWTqoVu
         t24QSaVuHUhcdk8okDJ3XupWIZtBvYmjJnPns5fEYrT5zmz5RRBEqCFadH0hyhKhZu9j
         cLnA6aiHZa6+U9ZbkYg0lqtHBucXo3L0BumI9EA9ENEOv4bCVNalBZdKAiuVc3/tMJrG
         3kvTAYoQEWzQmA4ftQdws06R9nOGEV+0/AVru4UiJ6+IXyCejUTxr8+wYCvmmO+p8YlZ
         RBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757740041; x=1758344841;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dkaA/5jekmOae8lvvUtnUz9sBHImM+xWxrfBTMgBDo=;
        b=UOuEaSvLFOB0EqrSmJShXKnGUrX/vrn+D20tKeCp6+gRd5iNpfBMdgdxvmaEY7bPSE
         grTDTpfdUxHR2a8NwRkWMzFvykanu7/hkMz67tuoJXgtuuNiBJGIrUd02vSpE+ySYFbK
         1L96mbWmHfeNIaULYSzRppa1fLhZKy+2xcAICSv2jOreSy+yjcmZiO0ETnPH8K3DDlYl
         Agj8X+XD85Q+PNFw4IJXw0pRwb1+hrtKnaMv9nRwCcOmQ2goHYzGpBJmoSV02KAGutuT
         spKWHF5Y0KFeTU+czsOf94vSXVm/APRstkXM1rVslvEWHBW0Iw+1cEDhWLmoSdpL3HaD
         qd4Q==
X-Gm-Message-State: AOJu0Yz3oI1YMUxcELVfAbFAVnrrNjM8ra6/2zrxFXtxN/BLtPWqmZws
	06EmxVUNELoQ20K3euy0lFDaeYkvpGzYNcdo9zWnjUl4X0uA5TyP1s5otuBLgQ==
X-Gm-Gg: ASbGncsH6sAaNgfQBmw7jcSK7UXxMWhIjVEdlf0xBMR9NBn+kSdFKbpfstxhP9/Ckxb
	CzRqYhBGKv9vQlJkrkZQKnGoeMoYvRznBYbeh1TvERD+IabAPy/wXd+Q6TKyt3QebRImze8PE8S
	f6ndZc39W7PKru6qGxoT18o9ju47pFZt8OLFTr56qFvAqPSKl0H0r/1GBc4Fs4eLqXWad+pxBmH
	m0tK9v+S8BUk6GSDCGeSr3k2jKEiIoYVrAjFwFIgvSp5Mb66HysGMnI8EPd+0syS69sYoVQXdC5
	6++UnHTLSd1MWYV9rrj4MQmAXZveI/kgdgQlk/qSMT3TYAK/eLP+PGM4G4t5efMc+X4N7g7z834
	enOEWCJFGgT7JuLZlt4fJnnUWTq3Ectbi5bEBF9+KpeT8EiRz3EY=
X-Google-Smtp-Source: AGHT+IFUY4SPpaBpOSa4GBh1/XK4qqE5LX63wa/12AlNirddFsCObYedFLH5KxaLrp1bpRC+lHRrcA==
X-Received: by 2002:a17:902:e810:b0:262:4878:9e13 with SMTP id d9443c01a7336-2624887e421mr1924285ad.26.1757740041482;
        Fri, 12 Sep 2025 22:07:21 -0700 (PDT)
Received: from ?IPV6:2600:8800:7280:a5d0::1b69? ([2600:8800:7280:a5d0::1b69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6b06sm65828985ad.17.2025.09.12.22.07.20
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 22:07:20 -0700 (PDT)
Message-ID: <09264d38-887f-4a12-961d-82da3b09ad57@gmail.com>
Date: Fri, 12 Sep 2025 22:07:19 -0700
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-sparse@vger.kernel.org
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
Subject: Project status
Autocrypt: addr=carlosrodrifernandez@gmail.com; keydata=
 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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nZ9GBjdwMCA3xyPzBZOs9eQ2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nZ9GBjdwMCA3xyPzBZOs9eQ2
Content-Type: multipart/mixed; boundary="------------I2paqmXYPEPf8IiW9Y2IyIqM";
 protected-headers="v1"
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
To: linux-sparse@vger.kernel.org
Message-ID: <09264d38-887f-4a12-961d-82da3b09ad57@gmail.com>
Subject: Project status

--------------I2paqmXYPEPf8IiW9Y2IyIqM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkknbSBjdXJyZW50bHkgbWFpbnRhaW5pbmcgdGhpcyBwYWNrYWdlIGluIEZlZG9y
YSBMaW51eCwgYW5kIEkgd2FzIA0Kd29uZGVyaW5nIGFib3V0IHRoZSBzdGF0dXMgb2YgdGhp
cyBwcm9qZWN0LiBJIHNlZSB0aGF0IHJlbGVhc2VzIHVzZWQgdG8gDQpjb21lIGEgZmV3IGEg
eWVhciwgYnV0IG5vIHJlbGVhc2UgaGFzIGJlZW4gZG9uZSBmb3IgYWJvdXQgNCB5ZWFycywg
DQpob3dldmVyIHRoZSBwYXRjaGVzIGFyZSBzdGlsbCBjb21pbmcgaW4gdGhlIG1haWxpbmcg
bGlzdCBsaWtlIGlmIGl0IHdlcmUgDQphY3RpdmVseSBiZWluZyBkZXZlbG9wZWQgc3RpbGwu
IFdoYXQgaXMgdGhlIGN1cnJlbnQgc3RhdHVzIG9mIHRoaXMgDQpwcm9qZWN0PyBUaGFuayB5
b3UgZm9yIGFueSBpbnNpZ2h0Lg0KDQpSZWdhcmRzLA0KDQpDYXJsb3MgUi5GLg0KDQo=

--------------I2paqmXYPEPf8IiW9Y2IyIqM--

--------------nZ9GBjdwMCA3xyPzBZOs9eQ2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEELMV13GzPmqlwKY7rR+vtBcM3Wx8FAmjE/AcFAwAAAAAACgkQR+vtBcM3Wx/m
YAwA2XB7nPxPLTItaXYwW/Ws1QuvpLKOIRSeSybU1ywsAjk9zRZdb9BAePWq2AjrXLGtSqyvvf1s
2wa8+BfGWWMTwe9OsNeyIYfxna62VFEL+4GrbzGoCTT53sZuvOY35SEdKd28u+xNtjAdJMz9eMgB
8WCMbkfsrH9qYf6gj2byXTmCcW07z8+YGjsW6WEiERMHkrhFB//9M3Y9H/5EFrohfMSO4vwVwQxE
6t3zYEN2SwhY6E58aPdq/t7GV3ywKehJhlbUKAqIB7qA0GE08rEqpY6me+tWCXGDJyjlJRFZP+Fn
2iZ6kWP98Pf/NSYHrBD1sr/d3rQOlsijRS9nuYXGszk/If+NcbaT9+1VK937V7KQlyvvr4JWN1/M
++NJfxnfZ9REi4/UEqJOzMDfUaJ/1T29hdSuE90MXby+kQyhbDFRFWbx1poPiGpmmipmuzVbWJco
j4PoBtM4cH7eibyTNBfy9WrmU8cKydSVZ9SUocemFPLHOEFj/4PjvGaW7TbV
=u9h2
-----END PGP SIGNATURE-----

--------------nZ9GBjdwMCA3xyPzBZOs9eQ2--
