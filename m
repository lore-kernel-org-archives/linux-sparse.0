Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1823A996
	for <linux-sparse@vger.kernel.org>; Wed, 12 Mar 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788257; cv=none; b=u9IFN6/cDEsK3i94pHLlV49UmsKakrpVVz/JxEGcyWB+ZLqB0v3EFgzNgXsh+rbmc7/SaR+hmHgy5JYehAfg9L1hkQvJGjJW4FlE5JRcWTiHQVHbRteOSFQlDoJB+cWxp+w/RpTZYddeaF3kKjOSiVaeHWpZKwfxknpV5R84TM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788257; c=relaxed/simple;
	bh=RwmZ9flI/qIQR+fO5LzMdKiN09uIsFymFXDsmHIon+4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=f1Hl15GS4GD8FHlRJeWdMhGkgOvhzhW8mKaeTECm9kBH3H6vqQV7JMB61SKq/lkABsHnmzmGPjXZfI7iTWTAZVwz4D+6ox1Atn+64ByWrMzRatJcFJF6LCFMnbTQLpykiVA0WBn6goef1QpZ2EGGoNrfSMOrQBKm3DnNSm5FtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=student.rau.am; spf=pass smtp.mailfrom=student.rau.am; dkim=pass (2048-bit key) header.d=student-rau-am.20230601.gappssmtp.com header.i=@student-rau-am.20230601.gappssmtp.com header.b=FSDeqr8P; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=student.rau.am
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.rau.am
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=student-rau-am.20230601.gappssmtp.com header.i=@student-rau-am.20230601.gappssmtp.com header.b="FSDeqr8P"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2feae794508so10245728a91.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Mar 2025 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student-rau-am.20230601.gappssmtp.com; s=20230601; t=1741788255; x=1742393055; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RwmZ9flI/qIQR+fO5LzMdKiN09uIsFymFXDsmHIon+4=;
        b=FSDeqr8Pg+3pwjYIxRPudBax0KxXIMMUSz0ttvXtcbQ/yXmwmjyNCwZBe6bl9c2LSd
         XlOkT7bHojDHc802qHvra3S8YLr4fuKpdzTwaedjZjt1UUzgO1NrDVp2grTUOr7KFFoL
         R1bmp4zLXeeMlX/ScKYKmNVxyQ0zD957L1dkwUb2I3/93eHva/EnZOpUPTVBO1vXh8B8
         L4DWUwCCkZA3h/FsQotr+l5Op3g8WpOy7kfKU/WNQuFOKi0pCl74GB/HAVDFlYkda/Tj
         Ep9scRPKUAhrxOAIbhgNihf1zK1L9/H7jdy0j0rrx9so8nQORc7B3+oYm+ghC55tav2T
         K83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788255; x=1742393055;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwmZ9flI/qIQR+fO5LzMdKiN09uIsFymFXDsmHIon+4=;
        b=sgoLS+LYd7hJAi8h9ugBs/fKLRLXerlHMcmkyrHPFFEvVe2qKly0G5NMSe/Mj28twc
         uEC+VDNXBOtyVyZ5qyL49Dt4lNiMAEz2+9VZio5Y+hYiANwbPgeuICgbOjy53I3fB/wv
         T9/Oz6qsUUlfL/FB0BItLpRxKETlRXIUFk97EIgtj3UWjulLGKQI3VcNUGbpRxbiUqrF
         QHTmT3aIA/jIr+/jJ7GliNOiQlu/AFp7hQ556FigbASYHNf5nUeapSzNW5Ae6KorYSIP
         r/yA45S2/t3UBz2d5OyMJlNRr6H7vQGGFwatSKDjd/TIdRXlfGNbhzHg338v2SjKGf3H
         x61Q==
X-Gm-Message-State: AOJu0Yzco8JFuXnAs2i7Imuohj9oc96iev2jQab/oFr7Y48lL0oadDbi
	a98oyDaTpXDgN5/CKIUB64FsQ5ZqfYPmpwt7dDOOvf8ZsHLRKsEaQ4WJyowA/ypxuwABi7E8j+7
	nDbGoGk7FPnCtSN441XA+JbdwsDdmnOcGS3Vt4chepY5jIfbHLk4=
X-Gm-Gg: ASbGncsHSf+7XYtjAFRSo3NXxZn61K+QyVM53ocTnarsIA0W84CWrD+f85OZPnyxVwk
	aaVYs/FfrpdCTaw9YTDWNRQ5096C2wha49fUwS6w9w8Qjs0/IMq9IPO1X0oh4n4Dd2T5BCeoIvi
	Ao32HXefNHnWdN8k+Vlup9s9Qzx3M=
X-Google-Smtp-Source: AGHT+IEjHQ1TpqMzPbm+yqn3Ho5boyv8byk+NE9yoFNSgTuyvsoXeKmIuqsGxzQcVW32jeolp6OkdFqecl441pvd+d4=
X-Received: by 2002:a17:90a:7785:b0:301:1d9f:4ba2 with SMTP id
 98e67ed59e1d1-3011d9f4c1cmr2808763a91.28.1741788254170; Wed, 12 Mar 2025
 07:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Edgar Khachatryan <khachatryan.edgar@student.rau.am>
Date: Wed, 12 Mar 2025 18:04:02 +0400
X-Gm-Features: AQ5f1JrihQ1Ib6Zw6OZ5Cm7b6tH2g2dyuFXgH-jd1AAZ3Hv-LPjx36ZGCMSDIZo
Message-ID: <CAN1=rvLAcxNqWzRR3EjtNgqk2A3T92iREEYTJdRog3OekK4=NA@mail.gmail.com>
Subject: Issue with Setting Up Sparse
To: linux-sparse@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002a47bb063025ae08"

--0000000000002a47bb063025ae08
Content-Type: multipart/alternative; boundary="0000000000002a47b9063025ae06"

--0000000000002a47b9063025ae06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My name is Edgar Khachatryan, and I am a student currently working on a
project that involves static analysis using Sparse. I have encountered an
issue where running Sparse with the command "sparse file.c" does not detect
simple memory issues such as memory leaks, double frees, or use-after-free
errors in a single file.

I have attempted to install Sparse versions 0.6.3 and 0.6.4 on different
Ubuntu releases (20.04, 22.04, and 24.04) with LLVM versions 11 and 12.
However, none of these combinations have worked as expected.

Following the installation instructions provided in the documentation, I
ran "make" and "make install" in the Sparse directory, but I was unable to
find further details regarding dependencies or required versions for proper
setup and functioning. As a result, I am reaching out to ask for
clarification on the following:

1) Are there specific dependencies or versions of libraries (e.g., libxml,
sqlite3, gtk3, etc.) that need to be installed to ensure Sparse functions
correctly?
2) Is there any additional documentation available beyond what was
provided? It would be very helpful to have more detailed instructions or
guidelines for setting up Sparse in different environments.

I also have the command-line output text that details the issues I=E2=80=99=
ve
encountered and The C source file I used as input. I would be happy to
share it with you if it would help resolve the problem.

Thank you in advance for your time and assistance. I look forward to your
response and any guidance you can provide to help resolve this issue.

Best regards,
Edgar Khachatryan,
Russian-Armenian University, Yerevan, Armenia

--0000000000002a47b9063025ae06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">My name is Edgar Khachatryan, and I am a student currently=
 working on a project that involves static analysis using Sparse. I have en=
countered an issue where running Sparse with the command &quot;sparse file.=
c&quot; does not detect simple memory issues such as memory leaks, double f=
rees, or use-after-free errors in a single file.<br><br>I have attempted to=
 install Sparse versions 0.6.3 and 0.6.4 on different Ubuntu releases (20.0=
4, 22.04, and 24.04) with LLVM versions 11 and 12. However, none of these c=
ombinations have worked as expected.<br><br>Following the installation inst=
ructions provided in the documentation, I ran &quot;make&quot; and &quot;ma=
ke install&quot; in the Sparse directory, but I was unable to find further =
details regarding dependencies or required versions for proper setup and fu=
nctioning. As a result, I am reaching out to ask for clarification on the f=
ollowing:<div><br>1) Are there specific dependencies or versions of librari=
es (e.g., libxml, sqlite3, gtk3, etc.) that need to be installed to ensure =
Sparse functions correctly?<br>2) Is there any additional documentation ava=
ilable beyond what was provided? It would be very helpful to have more deta=
iled instructions or guidelines for setting up Sparse in different environm=
ents.<br><br></div><div>I also have the command-line output text that detai=
ls the issues I=E2=80=99ve encountered and The C source file I used as inpu=
t. I would be happy to share it with you if it would help resolve the probl=
em.<br><br>Thank you in advance for your time and assistance. I look forwar=
d to your response and any guidance you can provide to help resolve this is=
sue.<div><br></div><div>Best regards,<br>Edgar Khachatryan,<br>Russian-Arme=
nian University, Yerevan, Armenia</div></div></div>

--0000000000002a47b9063025ae06--
--0000000000002a47bb063025ae08
Content-Type: text/x-csrc; charset="US-ASCII"; name="test.c"
Content-Disposition: attachment; filename="test.c"
Content-Transfer-Encoding: base64
Content-ID: <f_m85zq46c1>
X-Attachment-Id: f_m85zq46c1

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KCnZvaWQgbWVtb3J5X2xlYWso
KSB7CiAgICBpbnQgKnB0ciA9IChpbnQgKiltYWxsb2Moc2l6ZW9mKGludCkgKiAxMCk7ICAvLyBN
ZW1vcnkgYWxsb2NhdGVkIGJ1dCBuZXZlciBmcmVlZAogICAgaWYgKCFwdHIpIHsKICAgICAgICBw
cmludGYoIk1lbW9yeSBhbGxvY2F0aW9uIGZhaWxlZFxuIik7CiAgICAgICAgcmV0dXJuOwogICAg
fQogICAgcHRyWzBdID0gNDI7ICAvLyBTb21lIHVzYWdlCn0KCnZvaWQgZG91YmxlX2ZyZWUoKSB7
CiAgICBpbnQgKnB0ciA9IChpbnQgKiltYWxsb2Moc2l6ZW9mKGludCkgKiAxMCk7CiAgICBpZiAo
IXB0cikgewogICAgICAgIHByaW50ZigiTWVtb3J5IGFsbG9jYXRpb24gZmFpbGVkXG4iKTsKICAg
ICAgICByZXR1cm47CiAgICB9CiAgICBmcmVlKHB0cik7ICAvLyBGaXJzdCBmcmVlCiAgICBmcmVl
KHB0cik7ICAvLyBEb3VibGUgZnJlZSAodW5kZWZpbmVkIGJlaGF2aW9yKQp9Cgp2b2lkIHVzZV9h
ZnRlcl9mcmVlKCkgewogICAgaW50ICpwdHIgPSAoaW50ICopbWFsbG9jKHNpemVvZihpbnQpICog
MTApOwogICAgaWYgKCFwdHIpIHsKICAgICAgICBwcmludGYoIk1lbW9yeSBhbGxvY2F0aW9uIGZh
aWxlZFxuIik7CiAgICAgICAgcmV0dXJuOwogICAgfQogICAgZnJlZShwdHIpOyAgICAvLyBGcmVl
aW5nIG1lbW9yeQogICAgcHRyWzBdID0gNDI7ICAvLyBVc2UgYWZ0ZXIgZnJlZSAodW5kZWZpbmVk
IGJlaGF2aW9yKQp9CgppbnQgbWFpbigpIHsKICAgIG1lbW9yeV9sZWFrKCk7CiAgICBkb3VibGVf
ZnJlZSgpOwogICAgdXNlX2FmdGVyX2ZyZWUoKTsKICAgIHJldHVybiAwOwp9Cgo=
--0000000000002a47bb063025ae08
Content-Type: application/octet-stream; name=cmd_out
Content-Disposition: attachment; filename=cmd_out
Content-Transfer-Encoding: base64
Content-ID: <f_m85zq45y0>
X-Attachment-Id: f_m85zq45y0

JCBzcGFyc2UgLS12ZXJzaW9uCgowLjYuMwoKJCBzcGFyc2UgdGVzdC5jCiAKdGVzdC5jOjQ6MTg6
IHdhcm5pbmc6IG5vbi1BTlNJIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdtZW1v
cnlfbGVhaycKdGVzdC5jOjEzOjE4OiB3YXJuaW5nOiBub24tQU5TSSBmdW5jdGlvbiBkZWNsYXJh
dGlvbiBvZiBmdW5jdGlvbiAnZG91YmxlX2ZyZWUnCnRlc3QuYzoyMzoyMTogd2FybmluZzogbm9u
LUFOU0kgZnVuY3Rpb24gZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ3VzZV9hZnRlcl9mcmVlJwp0
ZXN0LmM6MzM6MTA6IHdhcm5pbmc6IG5vbi1BTlNJIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIG9mIGZ1
bmN0aW9uICdtYWluJwp0ZXN0LmM6NDo2OiB3YXJuaW5nOiBzeW1ib2wgJ21lbW9yeV9sZWFrJyB3
YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPwp0ZXN0LmM6MTM6Njogd2Fybmlu
Zzogc3ltYm9sICdkb3VibGVfZnJlZScgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0
YXRpYz8KdGVzdC5jOjIzOjY6IHdhcm5pbmc6IHN5bWJvbCAndXNlX2FmdGVyX2ZyZWUnIHdhcyBu
b3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/CgojIE5vdGU6IEl0IG91dHB1dHRlZCBu
b24tYXNjaWkgY2hhcmFjdGVycywgbm90IHRoYXQgdGhpcyBmaWxlIGlzIGNvcnJ1cHRlZAokIC4v
c3BhcnNlLWxsdm0gdGVzdC5jCiAKdGVzdC5jOjQ6MTg6IHdhcm5pbmc6IG5vbi1BTlNJIGZ1bmN0
aW9uIGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdtZW1vcnlfbGVhaycKdGVzdC5jOjEzOjE4OiB3
YXJuaW5nOiBub24tQU5TSSBmdW5jdGlvbiBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnZG91Ymxl
X2ZyZWUnCnRlc3QuYzoyMzoyMTogd2FybmluZzogbm9uLUFOU0kgZnVuY3Rpb24gZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24gJ3VzZV9hZnRlcl9mcmVlJwp0ZXN0LmM6MzM6MTA6IHdhcm5pbmc6IG5v
bi1BTlNJIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdtYWluJwp0ZXN0LmM6NDo2
OiB3YXJuaW5nOiBzeW1ib2wgJ21lbW9yeV9sZWFrJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQg
aXQgYmUgc3RhdGljPwp0ZXN0LmM6MTM6Njogd2FybmluZzogc3ltYm9sICdkb3VibGVfZnJlZScg
d2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8KdGVzdC5jOjIzOjY6IHdhcm5p
bmc6IHN5bWJvbCAndXNlX2FmdGVyX2ZyZWUnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBi
ZSBzdGF0aWM/CkJD77+977+9NWIKICAgICAgMCRKWe+/vWZd77+977+9TwogICAgICAgICAgICAg
ICAgUe+/vUwhCiAgICAgICAgICAgICAgICAgICAg77+9CiAgICAgICAgICAgICAgICAgICAgICHv
v70j77+9Qe+/vUkyOe+/ve+/vQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIO+/vWLv
v71FQu+/vQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIELvv70ySwoyUu+/
vUhw77+9ISNE77+977+9Qe+/vWTvv70gQ0bvv70g77+9MlLvv70qKCrvv70xfO+/vVzvv70g77+9
77+977+9IDIiSAkgZO+/ve+/vSLvv73vv73vv70i44Sh77+9TO+/ve+/vQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDvv73vv71M
VHNIagoxUW16YHTvv712QHpgdO+/ve+/vXrvv71677+9be+/vXjvv71477+9eO+/ve+/vXbvv71x
YHp277+977+9MHLvv71zIHowcu+/ve+/vWB077+9dkB6YHTvv73vv70wcu+/vXMgejBy77+977+9
YHTvv712QHpgdO+/ve+/vWB077+9dkB6YHTvv73vv71y77+9enLvv716cu+/vW1w77+9cO+/vXZA
bTBw77+9dkB6YHTvv73vv71w77+9cSB477+9cSB477+977+9enbvv71zIHpgdO+/ve+/vXLvv73v
v71A77+977+977+9NELWkCDvv73vv71Aw5Jg77+977+977+977+9JEBAQypoYEjvv70KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg77+977+977+9
WGBIdQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQEMqOSDvv70gUtmBQ++/ve+/ve+/ve+/ve+/vSTvv73vv70KMu+/vUzvv73vv70J
Jkfvv71DCu+/vTXvv73vv73vv708Cu+/ve+/ve+/vXHvv73vv71+77+9Qe+/vXDvv71dJivvv73v
v73vv73vv73vv71mPe+/vUM477+9w4xC77+9eXhz77+9cQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAg77+977+977+9MwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIELvv73vv73OoWYwPe+/vUM477+977+9Pe+/vUM977+9Pe+/vXjvv710cHlI77+9cHB6cHZ4
77+9cCDvv73vv73vv73vv70wbjDvv73vv73vv71QM++/ve+/vSHvv70h77+9YWYw77+9O++/ve+/
vTvvv71DOe+/vTzvv73vv70877+9O++/ve+/vXZge2g3aO+/vXJoN++/ve+/vXDvv73vv71wYHYo
du+/vXZ477+9d++/ve+/ve+/vXHvv71y77+977+9ee+/ve+/vSzvv73vv73vv73vv73vv73vv73v
v70wYsih77+9zKHvv73vv71h77+9IcSB77+9YdaQQznvv71DOe+/vUM577+9Qznvv73vv70477+9
Qzjvv70777+977+9L++/ve+/vTzvv73vv70777+9O++/ve+/vQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAg77+9ae+/vXBY77+9cnDvv710aHhg77+9dO+/vXTvv73vv73vv71T
77+977+9UO+/ve+/vUDvv70g77+9UDMgKO+/ve+/ve+/vUHvv70h3IHvv73vv73vv73vv73vv71m
UTjvv71DOu+/ve+/vTvvv71QJHZge2g3YO+/vXd4eO+/vVFM77+977+977+9UDNq77+9Ye+/vSHv
v73vv71+77+977+9Ie+/vWFU77+977+9OO+/ve+/vTvvv71DPe+/vUM577+977+9PO+/vUM777+9
77+9O++/vcOM77+9Cu+/vXnvv73vv71377+9eihy77+977+9XO+/ve+/ve+/ve+/vVDvv70wI++/
ve+/vUHvv73vv73vv73vv73vv71mSDvvv73vv70977+977+977+9OO+/vUM577+977+9PO+/ve+/
vTnvv73vv70777+9PO+/vUjvv712YO+/vXFY77+977+977+977+9YO+/ve+/ve+/vSDvv70w77+9
IO+/vVBu77+9MO+/vTDvv73vv73vv73vv73vv71Q77+9MEPvv73vv70h77+977+977+9Ye+/vWFG
77+977+977+9OO+/vTvvv73vv70v77+9Qzrvv71DOu+/vUM677+9Qzrvv71DPu+/vQoK77+9Qe+/
ve+/ve+/vSHvv70h77+977+9NO+/vWDvv71Q77+9IO+/vUDvv70g77+9UO+/ve+/ve+/ve+/vXko
77+9cGB2eO+/vXooclhw77+977+9OO+/vTvvv73vv70977+977+977+9PO+/ve+/vTvvv70777+9
Pe+/ve+/vTzvv71DOO+/ve+/vWEgIEQsdEYK77+9VFHvv73vv71Y77+977+9I++/vWDvv70wRHLv
v70hCiAgICAgICAgICAgICAgICAgZiFI77+9bELvv71kIO+/ve+/vSVGCgrvv71g77+977+9We+/
vUHDgQkx77+977+9b++/vWrvv70mQe+/ve+/vV/vv73FsO+/vSV9Qlnvv73vv71Q77+9NyDvv703
YSAlRCx0Rgrvv73vv71QRyDvv71yLCRHI++/vWDvv70sQ3Lvv70hCiAgICAgICAgICAgICAgICAg
ICBmIUjvv73vv71B77+9IDRM77+977+977+977+9QTBo77+9YO+/vWAxKO+/ve+/vTlmCQog77+9
ZX5C77+934BQ77+9RkHvv73vv73vv73vv73DsO+/vUEKICAgICAgICAgICAgICAgICAga++/vVvv
v73vv71+be+/ve+/ve+/ve+/vU1r77+977+9YSAmRCx0Rgrvv71UUe+/ve+/vVjvv73vv70j77+9
YO+/vTBEcu+/vSEKICAgICAgICAgICAgICAgICBmIUjvv73vv71B77+9IDRN77+977+977+977+9
QO+/vUDvv70oMEsw77+977+9IiXvv73vv73vv70KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZB77+9du+/ve+/vVDvv70g77+977+9QWvvv73vv71B77+977+9
77+9RO+/vda7X++/vUTvv73Wu2/vv73vv71Q77+977+9CnEgMiLvv73vv71oOe+/ve+/ve+/vT1l
I++/vWBAI++/vWBAMO+/ve+/vQogICAgICAgICAgICAgVe+/ve+/vUgvTFhYCkh377+9SAoKCu+/
ve+/ve+/ve+/vSTvv73vv70kISHvv73vv73vv70kJwogICAgICAgICAgICAgICAnCiAgICAgICAg
ICAgICAgICDvv73vv73vv73vv70kMjLvv73vv73vv70kNjbvv73vv73vv73vv70kRETvv73vv73v
v73vv70k77+977+977+977+977+977+977+9Cgrvv73vv73vv71dCiAgICAp77+9NS5zdHIuc3Ry
LjEuc3RyLjJtZW1vcnlfbGVha21hbGxvY3ByaW50ZmRvdWJsZV9mcmVlZnJlZXVzZV9hZnRlcl9m
cmVlbWFpbjExLjEuMCA3ZTk5YmRkZmVhYWIyNzEzYThiYjZjYTUzOGRhMjViNjZlNmVmYzU5eDg2
XzY0LXVua25vd24tbGludXgtZ251c3BhcnNlCgo=
--0000000000002a47bb063025ae08--
