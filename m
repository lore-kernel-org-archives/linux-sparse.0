Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DC2DE710
	for <linux-sparse@vger.kernel.org>; Thu, 25 Sep 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818229; cv=none; b=NL57QHLidjF8yvPnaFKkirH89YraC9Y5z1C4Oerp1ofHuuhOzxfFoiCEbgAB/v3L8GEkVOessAh/KIhhO/DFeQhz798VikdHO9pxN2bTJyGEYHdcelVbLtE+puWUFVepo0a6wuh3yXXqXRPtHDqDWj5kf31KTNOP8emd1eTFdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818229; c=relaxed/simple;
	bh=w7Bu0LtBL7FlCubET+MkDLPnk/t3nPymw0giT9qg/gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBl06qa3EcF3lfNa2gybMi4g6qHwer8P5DAnf3uLEvbF0YPPV2h+dvoJymB94sqZQyFuqmblLSR+qj5nyNZ+7OlbV0VntCgNJIP3gDezLd1TArAibbL0nPIdpdiZOleeTLMfEpnG9xJuT15MVHSMVLD08t601I+FpPQMdGlH1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJN7hkXo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJN7hkXo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27ee41e0798so6386545ad.1
        for <linux-sparse@vger.kernel.org>; Thu, 25 Sep 2025 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758818227; x=1759423027; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w7Bu0LtBL7FlCubET+MkDLPnk/t3nPymw0giT9qg/gI=;
        b=jJN7hkXoQkiTmdVrxGQtuCK7DpKzom+8GSEgqfaRn0iREVu3bJtn7baAtXcLFaoIbI
         VnnCJDd+6y4WcDcKW2DbA0fydFlTb0UQD/vCn4TGEqK23+hq91TPLbHqIfJAs+ZpVany
         EvB/8bCnjei8nk1Q3jzvBaQUkCkdWFnjvYC+IyKt0GF2hKDiq6zaQetuaPtOtOqr+sLR
         X9HQ9yyDR1xJgQ1XqEE4awmRc2KL4JcXPBrSfa7Y/1ouZFdA01QlWVBibevabQAZZGr6
         mZAd5OD0v/Ak2NDoS3wHvSqjiR+UzahBObnKNATxHpeNoPpxBOHPsLuqkXkYTuMK48Yq
         aDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818227; x=1759423027;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7Bu0LtBL7FlCubET+MkDLPnk/t3nPymw0giT9qg/gI=;
        b=rxsDX93J+iTPCAYQwa8pKUsWT+o4lpXBB9HTm+uMASm0csvnknw4vL0lQSLMzjjTpm
         1+dHX1kN0YUIWWtIrTCeJFVb18qZtpGtavLYF5ET53O2+qNBh4K2SN2RXydlK955KR2v
         hSXvlfQK6vcV+usbJ0gWpvAvwbG7ilPyh4BxOUrgazwrsbhheywevvrlPcYjfrNMvXvg
         6nfkiyPVeyhZUXIiaXNTnrC5dhFLb4BCEoEpvtZ9sstuqN9r9eTpRBHTjPkp8334IAWR
         sjwBvP3RFn9D6xaW1FMCMhYbAgxCU3YdbPpPrKoOdNvft87o8uDoThWmmjsZ54ZI+2cj
         IZWA==
X-Gm-Message-State: AOJu0YzuGh3xZk6sOe45wGqRf91RFaBT7pXSjlEmfDXG1S9TEqy20d2L
	6Ns6IUXbaPi8v7xvNZY5vY4OnClri+JUtchSAPeFcqb7p6yjtU5PyDmmCF/Spw==
X-Gm-Gg: ASbGncvU55XWdrEui0Wr1E8uFIMcG24yCJ2/iUfUs+lSx0yulYAMCQ8SsubXAUggCR5
	DPv55TAtodaqjfD2mTZmPQvf+NKLgh05qL1I0zBhmQdPeTKIvr/cxeB0HdUvpCGNT8maOK0eaTh
	sANqIStgUdG5eELLAcT8slowQjQ+yEGdF+rtL0JUmrGVzLg43hpONd74wVgB847YkoAU1pDEj1P
	gmK3DleYeqKsHTzQmqoeYWD0nNUslCQc5JWRLHcGtKcmZ0xGzf5iewi0eNduJr6zzx3p/SwO7Dq
	o79E7v5ypEBnwYX2jmLIsXdaWGsKgMB4VWGsRLxGxjDaalxIBurI9Z2kB9Zs1mlNsZINuHZU2ut
	hZiQujCfHAg9LF9Lgx3aAVlSn9b7dOxt7HZxI0gjo8XpXnsvbmrlDmvnYofXpPw==
X-Google-Smtp-Source: AGHT+IE8jPAQ3JM2/XcrpzYeWjjDL7UCTRvQ9xtFviFlTqe9oyLj5W+fujX8Vk42xPS+3zV+eQFWjg==
X-Received: by 2002:a17:903:37c3:b0:272:8c5f:1325 with SMTP id d9443c01a7336-27ed4a30cfemr48118805ad.36.1758818226998;
        Thu, 25 Sep 2025 09:37:06 -0700 (PDT)
Received: from ?IPV6:2600:8800:7280:a5d0::1b69? ([2600:8800:7280:a5d0::1b69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66f305bsm28774105ad.32.2025.09.25.09.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 09:37:06 -0700 (PDT)
Message-ID: <a7d63c3d-adcc-4d27-84bc-4681692ad7e7@gmail.com>
Date: Thu, 25 Sep 2025 09:37:05 -0700
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Project status
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org
References: <09264d38-887f-4a12-961d-82da3b09ad57@gmail.com>
 <CACePvbXoyMRLwNJpui9GGf30T8UCzo5JT2jPTBQsSnBtT9kZYQ@mail.gmail.com>
Content-Language: en-US
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
Autocrypt: addr=carlosrodrifernandez@gmail.com; keydata=
 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
In-Reply-To: <CACePvbXoyMRLwNJpui9GGf30T8UCzo5JT2jPTBQsSnBtT9kZYQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------w0Xp5BPBCdhi3qzlOnarfRBB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------w0Xp5BPBCdhi3qzlOnarfRBB
Content-Type: multipart/mixed; boundary="------------B08MkRfOdoNIXkw9Oto75agH";
 protected-headers="v1"
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org
Message-ID: <a7d63c3d-adcc-4d27-84bc-4681692ad7e7@gmail.com>
Subject: Re: Project status
References: <09264d38-887f-4a12-961d-82da3b09ad57@gmail.com>
 <CACePvbXoyMRLwNJpui9GGf30T8UCzo5JT2jPTBQsSnBtT9kZYQ@mail.gmail.com>
In-Reply-To: <CACePvbXoyMRLwNJpui9GGf30T8UCzo5JT2jPTBQsSnBtT9kZYQ@mail.gmail.com>

--------------B08MkRfOdoNIXkw9Oto75agH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQ2hyaXMsDQoNCkkgaGF2ZSBub3RoaW5nIGluIHBhcnRpY3VsYXIsIGp1c3Qgd2FudGVk
IHRvIGtub3cgaWYgdGhlIHByb2plY3Qgd2FzIA0KZ29pbmcgdW5tYWludGFpbmVkLiBJJ20g
Z2xhZCB0byBoZWFyIGl0IGlzIGJlaW5nIHBpY2tlZCB1cC4NCg0KUmVnYXJkcywNCg0KQ2Fy
bG9zIFIuRi4NCg0KT24gOS8yNS8yNSA5OjA4IEFNLCBDaHJpcyBMaSB3cm90ZToNCj4gSGkg
Q2FybG9zLA0KPg0KPiBJIHdhcyB0aGUgc3BhcnNlIG1haW50YWluZXIgYmV0d2VlbiAyMDA5
IHRvIDIwMTguIEkgYW0gYmFjayBhcyB0aGUNCj4gc3BhcnNlIG1haW50YWluZXIgc2luY2Ug
bGFzdCB3ZWVrZW5kLg0KPg0KPiBTdGlsbCBjYXRjaGluZyB1cCB3aXRoIHRoaW5ncyBhbmQg
ZmluZGluZyB0aGUgbWlzc2luZyBwYXRjaCBpbiB0aGUNCj4gbWFpbCBsaXN0IHRvIGFwcGx5
IHRvIHNwYXJzZS4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFueSB3aXNoDQo+
IGxpc3Qgb3IgcGFydGljdWxhciBwYXRjaCB5b3Ugd2FudCBpbiB0aGUgbmV3IHNwYWNlIHJl
bGVhc2UuIEkgY2FuIGN1dA0KPiBhIHNwYXJzZSByZWxlYXNlIGFmdGVyIHRoZSBpbml0aWFs
IGJhdGNoZWQgY2F0Y2ggdXAuDQo+DQo+IENocmlzDQo+DQo+DQo+IE9uIEZyaSwgU2VwIDEy
LCAyMDI1IGF0IDEwOjA44oCvUE0gQ2FybG9zIFJvZHJpZ3Vlei1GZXJuYW5kZXoNCj4gPGNh
cmxvc3JvZHJpZmVybmFuZGV6QGdtYWlsLmNvbT4gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBJ
J20gY3VycmVudGx5IG1haW50YWluaW5nIHRoaXMgcGFja2FnZSBpbiBGZWRvcmEgTGludXgs
IGFuZCBJIHdhcw0KPj4gd29uZGVyaW5nIGFib3V0IHRoZSBzdGF0dXMgb2YgdGhpcyBwcm9q
ZWN0LiBJIHNlZSB0aGF0IHJlbGVhc2VzIHVzZWQgdG8NCj4+IGNvbWUgYSBmZXcgYSB5ZWFy
LCBidXQgbm8gcmVsZWFzZSBoYXMgYmVlbiBkb25lIGZvciBhYm91dCA0IHllYXJzLA0KPj4g
aG93ZXZlciB0aGUgcGF0Y2hlcyBhcmUgc3RpbGwgY29taW5nIGluIHRoZSBtYWlsaW5nIGxp
c3QgbGlrZSBpZiBpdCB3ZXJlDQo+PiBhY3RpdmVseSBiZWluZyBkZXZlbG9wZWQgc3RpbGwu
IFdoYXQgaXMgdGhlIGN1cnJlbnQgc3RhdHVzIG9mIHRoaXMNCj4+IHByb2plY3Q/IFRoYW5r
IHlvdSBmb3IgYW55IGluc2lnaHQuDQo+Pg0KPj4gUmVnYXJkcywNCj4+DQo+PiBDYXJsb3Mg
Ui5GLg0KPj4NCg==

--------------B08MkRfOdoNIXkw9Oto75agH--

--------------w0Xp5BPBCdhi3qzlOnarfRBB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEELMV13GzPmqlwKY7rR+vtBcM3Wx8FAmjVb7EFAwAAAAAACgkQR+vtBcM3Wx+x
3wv/ZXp1LGI+j8Pdko7rny0Fl6ye1B3Iip/8sAs9WddIWCzvJWz+1QqhWbxWKhaivVkB4z5RUy0+
dpVPcp8SqDBjJb6P2AVQuQvDyj23F88dmWH4M+dgRlQYtT0x62GzhhSyjs1TMCHuqkby/jLX6CDK
Il0BxchEoB8Rsj/zm6MBfNK6nBrVEZHIXpY9QmmzNnUxsL7VUNRd39+RjET+N8E51XUNkQBxoB2Q
mmQGLgkUAK+ORyncaCxJ+okV6O3pUg9EI28aPuJLEpehvyEtG7MzthCX8417z2FHr4WNHln4dx8Q
IdikNjsveqowhURA3591wucuxImnRwOK8Pb5rr7/Fsb4Kd3Xtefmf8Ni5fP8/WUhHTS5IQ0cO/Dx
7u2DBuDUa0Ml0IADFZK1HI/UnGqB/VYi92vgXUIVIzPRHjYL0gXN+eosOLWpObYexmU9SPgmVjoR
1xp6XeMIXd0gVbxOZ5/N24goCFeub2XGbkFcxhk7IuePiQCnwOnobEI/lvk2
=UKmH
-----END PGP SIGNATURE-----

--------------w0Xp5BPBCdhi3qzlOnarfRBB--
