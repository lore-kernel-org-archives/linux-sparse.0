Received: from mail-ot1-f56.google.com (mail-ot1-f56.google.com [209.85.210.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4752A1B2
	for <linux-sparse@vger.kernel.org>; Mon,  9 Jun 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749431375; cv=none; b=Yj9q27JlL6UjkCqUWsqzQj3oRIN/gOP/zotQcPVHW6XY3H2lMn40RNo9gwHhDK3a7lnvdEfqAoRPievvMEaeKYV64jyrkMWI95Y3Mh2g6c6oNBdVlSlebobhilD7KiCTGTlog8hOa6fuY3MFyCn9YxlUh/15Z0seGze24L/aYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749431375; c=relaxed/simple;
	bh=oWhH+dV9wtZCYQJdr0mgsmexPw66r8Pp+UdeMWwfEdo=;
	h=Date:From:To:Cc:Message-Id:Subject:MIME-Version:Content-Type; b=Td/I7bfPNMa3zezIzxfr2fTjXay4pKucr+EQeOrnKHSlc+JDjiVWUhJWVP15CFy6U9Cj2AUtdyzs2AhS1+GEA87vZLG7gc4X1/wFUSBWeaFa+PyEDQHkX5j7FYIK+GXB6IOtABRqwrBE8qpRjVqwnzc19cko4udT19VNbsl1RdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancd.us; spf=none smtp.mailfrom=ancd.us; dkim=pass (2048-bit key) header.d=ancd-us.20230601.gappssmtp.com header.i=@ancd-us.20230601.gappssmtp.com header.b=WWae5Ri8; arc=none smtp.client-ip=209.85.210.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancd.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ancd.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ancd-us.20230601.gappssmtp.com header.i=@ancd-us.20230601.gappssmtp.com header.b="WWae5Ri8"
Received: by mail-ot1-f56.google.com with SMTP id 46e09a7af769-72bc266dc24so4656300a34.2
        for <linux-sparse@vger.kernel.org>; Sun, 08 Jun 2025 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ancd-us.20230601.gappssmtp.com; s=20230601; t=1749431373; x=1750036173; darn=vger.kernel.org;
        h=mime-version:subject:message-id:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xecOpGwNrtLz7obrC6XSIWlvvhqJkOHNo19WBt5fr6I=;
        b=WWae5Ri8rbHtojoHJbOsQ8MabZ4mbbCfEqR+5piKlqTYt0GIw4uilaDnMojLLYOeh3
         kSr12M3FRxLgZsZTwCeSllCNTbRwOWxlbCfuDVee8bAxBTcF98IM9bPqujARujgz96WD
         RocJJJNswcCZPmwKmMOVWoQLZdhZnYfSOxNftp4tJGaVAFPGs57grivue7Mess4kVSrs
         Qpiy1uLP7OxTM8AdOIJJaTsFEYPXxtDsB4GJso0IHcY4eiugi5QDzWglkO2sy6+NLQuB
         B+NZZ0T/+ApYUbvGw0PEVYeeqia6JiAxfGVJMLjqaSQ/8h3yUA1FSJlyDyxP7W+J3EX4
         VBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749431373; x=1750036173;
        h=mime-version:subject:message-id:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xecOpGwNrtLz7obrC6XSIWlvvhqJkOHNo19WBt5fr6I=;
        b=A1na6lUoNkshisgGw7U1b+q2oYv7t+fe76XO9wpUC8h7LF3PzrlHaN4zHtotxebsJ8
         H+afGNM+Q20E5B7AHoMsJuBheOhlrPwt7Xj6aXj81m7KLxZ5SmJbFoD6Un0DFsk+Zdf5
         FU9lMvxMb8EOJKj6/AMNN2d7/MSK/EitqfnxewUQastqdtW4ymVUkCQBhBscF2nlq3C2
         9hYopKj0M+gMvbs3kjJn5c7wtba7ZUozGVBUq/XcHI2LYme/66qjx/S+58JZXNzeQZv3
         QaizKi/VofWMHUkUve4rJL1qfShyGEn/wu1LZq4mkX9yTXagFz8aWATSUrnnxcr8rZ1M
         HqmA==
X-Forwarded-Encrypted: i=1; AJvYcCWmlyIXoP7Qs0K18eYUDNPQd66pIJsFD/3RafJ9jAcuD3yE+lD1kue65TfYaDjLL//GephmjV524D9scZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTfLzVwXhacvCp4Y6HvGWKPQdYdIDqO8wUASFqq4vOLxOnLt7
	SASdybhZ/Xbbdmf9z3FfTgS+CedgghHp7VRDrAiRH7fzCK7RDY3pIE1VIltxn2kmtA5ZeJt5fqa
	Gj9Sx9Fkz7j5p4A==
X-Google-Smtp-Source: AGHT+IGtPfZ2YOtBqj/+aFTy5hU7J6U6t1b5j7pCWCoREcHOTP0sOGhCIXfzGFPZ7TL7xqWqWqZ9hqZYIw==
X-Received: by 2002:a05:6808:384c:b0:403:3c95:3683 with SMTP id 5614622812f47-409051ccdedmr8280770b6e.19.1749431373007;
        Sun, 08 Jun 2025 18:09:33 -0700 (PDT)
X-Google-Already-Archived: Yes
X-Google-Already-Archived-Group-Id: 8a5741539f
X-Google-Doc-Id: 296b780e8574c
X-Google-Thread-Id: c5ea258ede0beffa
X-Google-Message-Url: http://groups.google.com/a/ancd.us/group/hubareevesami/msg/296b780e8574c
X-Google-Thread-Url: http://groups.google.com/a/ancd.us/group/hubareevesami/t/c5ea258ede0beffa
X-Google-Web-Client: true
Date: Sun, 8 Jun 2025 18:09:32 -0700 (PDT)
From: Email Marketing software <hubareevesami@ancd.us>
To: Email Marketing software <hubareevesami@ancd.us>
Cc: shssafe@uhb.nhs.uk, william.sanderson@fraserhealth.ca,
	dao-ban-bih@nic.in, teking@gannett.com, f.RCBA-CABIN.f@ec.gc.ca,
	president@villageretirementwa.org.au, inessa@gardentranslation.com,
	jcfahselt@seattleschools.org, linux-sparse@vger.kernel.org,
	snb5@delsot.ru, contact@lawyerforall.com, james.hutton@sarasin.co.uk,
	Charles.Brogan@greatheartstxschools.org, m.kubanek@schoenherr.eu,
	s.cannon@oceans.ubc.ca, info@docscentre.com.au, zakup@termet.com.pl,
	ricardo@delgo.com.br, advertising@junkjaunt.com,
	olemcya@rcdea.org.uk, support@oqtima.com,
	 <daniel.miggitsch@villach.at>
Message-Id: <305f4b5b-6691-4705-9016-8649db504ee2n@ancd.us>
Subject: =?UTF-8?Q?High-speed,_Bulk,_Multi-th?=
 =?UTF-8?Q?readed,_Built-in_Proxies_=EF=BC=8E=EF=BC=8E?=
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_332764_934419141.1749431372392"

------=_Part_332764_934419141.1749431372392
Content-Type: multipart/alternative; 
	boundary="----=_Part_332765_2044906908.1749431372392"

------=_Part_332765_2044906908.1749431372392
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

CgrinJQuINCi0YvRgdGP0YfQuCDQuCDRgdC+0YLQvdC4INGC0YvRgdGP0Ycg0L/QuNGB0LXQvCDQ
vtGC0L/RgNCw0LLQu9GP0Y7RgtGB0Y8g0LIg0LTQtdC90YwuCgrinJQuINCV0LTQuNC90YHRgtCy
0LXQvdC90L7QtSDQv9GA0L7Qs9GA0LDQvNC80L3QvtC1INC+0LHQtdGB0L/QtdGH0LXQvdC40LUg
0L3QsCDRgNGL0L3QutC1LCDQutC+0YLQvtGA0L7QtSDQuNGB0L/QvtC70YzQt9GD0LXRgiAK0LLQ
tdCxLdGA0LXQttC40LwgKyDQv9GA0L7RgtC+0LrQvtC7IEhUVFAg0LTQu9GPINC+0YLQv9GA0LDQ
stC60Lgg0L/QvtGH0YLRiy4g0J7QvdC+INC/0L7Qu9C90L7RgdGC0YzRjiDQuNC80LjRgtC40YDR
g9C10YIgCtGA0YPRh9C90L7QuSDQstGF0L7QtCDQuCDQvtGC0L/RgNCw0LLQutGDINCx0YDQsNGD
0LfQtdGA0LAgQ2hyb21lLgoK4pyULiDQl9Cw0L/Rg9GB0Log0L7QtNC90LjQvCDRidC10LvRh9C6
0L7QvCwg0L/RgNC+0YLQvtC60L7QuyBIVFRQLCDQv9C+0LvQvdC+0YHRgtGM0Y4g0LDQstGC0L7Q
vNCw0YLQuNC30LjRgNC+0LLQsNC90L3Ri9C5LCAK0LLRi9GB0L7QutC+0YHQutC+0YDQvtGB0YLQ
vdC+0LksINC80LDRgdGB0L7QstGL0LksINC80L3QvtCz0L7Qv9C+0YLQvtGH0L3Ri9C5LCDQstGB
0YLRgNC+0LXQvdC90YvQtSDQv9GA0L7QutGB0LguCgrinJQuINCR0LXRgdC/0LvQsNGC0L3QsNGP
INC/0L7Qu9C90L7RhNGD0L3QutGG0LjQvtC90LDQu9GM0L3QsNGPINC/0YDQvtCx0L3QsNGPINCy
0LXRgNGB0LjRjyDQvdCwIDMg0LTQvdGPLgoKU0lURTogc2hvcnR1cmwuYXQvdThNdHIgCgpURzog
d293b2Zyb20yMDA4Cgoo0K3RgtC+INGN0LvQtdC60YLRgNC+0L3QvdC+0LUg0L/QuNGB0YzQvNC+
INCw0LLRgtC+0LzQsNGC0LjRh9C10YHQutC4INC+0YLQv9GA0LDQstC70Y/QtdGC0YHRjyDQvdCw
0YjQuNC8INC/0YDQvtCz0YDQsNC80LzQvdGL0LwgCtC+0LHQtdGB0L/QtdGH0LXQvdC40LXQvCkK
Ciphc3N1cmUgZmVhc2libGUuKgo=
------=_Part_332765_2044906908.1749431372392
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<p><font color=3D#800000><font color=3D#000000 size=3D5 face=3D"Times New R=
oman"><span style=3D'FONT-SIZE: medium; FONT-FAMILY: "Microsoft YaHei"; WHI=
TE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FLOAT: none; FON=
T-WEIGHT: 400; COLOR: rgb(0,102,0); FONT-STYLE: normal; TEXT-ALIGN: left; O=
RPHANS: 2; WIDOWS: 2; DISPLAY: inline !important; LETTER-SPACING: normal; T=
EXT-INDENT: 0px; font-variant-ligatures: normal; font-variant-caps: normal;=
 -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-d=
ecoration-style: initial; text-decoration-color: initial'>=E2=9C=94. <font =
color=3D#800000>=D0=A2=D1=8B=D1=81=D1=8F=D1=87=D0=B8 =D0=B8 =D1=81=D0=BE=D1=
=82=D0=BD=D0=B8 =D1=82=D1=8B=D1=81=D1=8F=D1=87 =D0=BF=D0=B8=D1=81=D0=B5=D0=
=BC =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D1=8F=D1=8E=D1=82=D1=81=D1=
=8F =D0=B2 =D0=B4=D0=B5=D0=BD=D1=8C.</font></span></font></font></p><p><fon=
t color=3D#800000><font color=3D#000000 size=3D5 face=3D"Times New Roman"><=
span style=3D'FONT-SIZE: medium; FONT-FAMILY: "Microsoft YaHei"; WHITE-SPAC=
E: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FLOAT: none; FONT-WEIGH=
T: 400; COLOR: rgb(0,102,0); FONT-STYLE: normal; TEXT-ALIGN: left; ORPHANS:=
 2; WIDOWS: 2; DISPLAY: inline !important; LETTER-SPACING: normal; TEXT-IND=
ENT: 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webki=
t-text-stroke-width: 0px; text-decoration-thickness: initial; text-decorati=
on-style: initial; text-decoration-color: initial'>=E2=9C=94. <font color=
=3D#800000>=D0=95=D0=B4=D0=B8=D0=BD=D1=81=D1=82=D0=B2=D0=B5=D0=BD=D0=BD=D0=
=BE=D0=B5 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BD=D0=BE=D0=
=B5 =D0=BE=D0=B1=D0=B5=D1=81=D0=BF=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B0 =D1=80=D1=8B=D0=BD=D0=BA=D0=B5, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D0=
=BE=D0=B5 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B5=D1=82 =D0=
=B2=D0=B5=D0=B1-=D1=80=D0=B5=D0=B6=D0=B8=D0=BC + =D0=BF=D1=80=D0=BE=D1=82=
=D0=BE=D0=BA=D0=BE=D0=BB HTTP =D0=B4=D0=BB=D1=8F =D0=BE=D1=82=D0=BF=D1=80=
=D0=B0=D0=B2=D0=BA=D0=B8 =D0=BF=D0=BE=D1=87=D1=82=D1=8B. =D0=9E=D0=BD=D0=BE=
 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=8C=D1=8E =D0=B8=D0=BC=D0=B8=
=D1=82=D0=B8=D1=80=D1=83=D0=B5=D1=82 =D1=80=D1=83=D1=87=D0=BD=D0=BE=D0=B9 =
=D0=B2=D1=85=D0=BE=D0=B4 =D0=B8 =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BA=
=D1=83 =D0=B1=D1=80=D0=B0=D1=83=D0=B7=D0=B5=D1=80=D0=B0 Chrome.<br /></font=
></span></font></font><font color=3D#800000><font color=3D#000000 size=3D5 =
face=3D"Times New Roman"><span style=3D'FONT-SIZE: medium; FONT-FAMILY: "Mi=
crosoft YaHei"; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: non=
e; FLOAT: none; FONT-WEIGHT: 400; COLOR: rgb(0,102,0); FONT-STYLE: normal; =
TEXT-ALIGN: left; ORPHANS: 2; WIDOWS: 2; DISPLAY: inline !important; LETTER=
-SPACING: normal; TEXT-INDENT: 0px; font-variant-ligatures: normal; font-va=
riant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickne=
ss: initial; text-decoration-style: initial; text-decoration-color: initial=
'><br />=E2=9C=94. <font color=3D#800000>=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=
=BA =D0=BE=D0=B4=D0=BD=D0=B8=D0=BC =D1=89=D0=B5=D0=BB=D1=87=D0=BA=D0=BE=D0=
=BC, =D0=BF=D1=80=D0=BE=D1=82=D0=BE=D0=BA=D0=BE=D0=BB HTTP, =D0=BF=D0=BE=D0=
=BB=D0=BD=D0=BE=D1=81=D1=82=D1=8C=D1=8E =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=
=B0=D1=82=D0=B8=D0=B7=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9=
, =D0=B2=D1=8B=D1=81=D0=BE=D0=BA=D0=BE=D1=81=D0=BA=D0=BE=D1=80=D0=BE=D1=81=
=D1=82=D0=BD=D0=BE=D0=B9, =D0=BC=D0=B0=D1=81=D1=81=D0=BE=D0=B2=D1=8B=D0=B9,=
 =D0=BC=D0=BD=D0=BE=D0=B3=D0=BE=D0=BF=D0=BE=D1=82=D0=BE=D1=87=D0=BD=D1=8B=
=D0=B9, =D0=B2=D1=81=D1=82=D1=80=D0=BE=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BF=
=D1=80=D0=BE=D0=BA=D1=81=D0=B8.</font></span></font></font></p><p><font col=
or=3D#800000><font color=3D#000000 size=3D5 face=3D"Times New Roman"><span =
style=3D'FONT-SIZE: medium; FONT-FAMILY: "Microsoft YaHei"; WHITE-SPACE: no=
rmal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FLOAT: none; FONT-WEIGHT: 40=
0; COLOR: rgb(0,102,0); FONT-STYLE: normal; TEXT-ALIGN: left; ORPHANS: 2; W=
IDOWS: 2; DISPLAY: inline !important; LETTER-SPACING: normal; TEXT-INDENT: =
0px; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-tex=
t-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-st=
yle: initial; text-decoration-color: initial'>=E2=9C=94. <font color=3Dred =
size=3D5>=D0=91=D0=B5=D1=81=D0=BF=D0=BB=D0=B0=D1=82=D0=BD=D0=B0=D1=8F =D0=
=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=84=D1=83=D0=BD=D0=BA=D1=86=D0=B8=D0=BE=D0=BD=
=D0=B0=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B1=D0=BD=D0=B0=
=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=BD=D0=B0 3 =D0=B4=D0=BD=D1=
=8F.</font></span></font></font></p><p><font size=3D6><font color=3Dred><fo=
nt face=3D"Microsoft YaHei"></font></font></font></p><p><font size=3D4>SITE=
: <font color=3Dblue>shorturl.at/u8Mtr </font></font></p><p><font size=3D4>=
<font color=3D#333300>TG</font>: <font color=3Dgreen>wowofrom2008</font></f=
ont></p><p><font color=3D#800000 size=3D4>(=D0=AD=D1=82=D0=BE =D1=8D=D0=BB=
=D0=B5=D0=BA=D1=82=D1=80=D0=BE=D0=BD=D0=BD=D0=BE=D0=B5 =D0=BF=D0=B8=D1=81=
=D1=8C=D0=BC=D0=BE =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=
=D0=B5=D1=81=D0=BA=D0=B8 =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D1=8F=
=D0=B5=D1=82=D1=81=D1=8F =D0=BD=D0=B0=D1=88=D0=B8=D0=BC =D0=BF=D1=80=D0=BE=
=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BD=D1=8B=D0=BC =D0=BE=D0=B1=D0=B5=D1=81=
=D0=BF=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC)</font></p><p><strong>assu=
re feasible.</strong><font color=3D#0000ff><br /></font></p>
------=_Part_332765_2044906908.1749431372392--

------=_Part_332764_934419141.1749431372392--
