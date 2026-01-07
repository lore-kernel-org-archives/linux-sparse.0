Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141FA342504
	for <linux-sparse@vger.kernel.org>; Wed,  7 Jan 2026 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814926; cv=none; b=Jfz+uFGgbVZq58ITWDmxYxfkLfFCm9//BvMFgCkeyFgYKgZZYtpeneIA1McAwwxcBtcv5uKPLNUN0wXtF6IOaZcgoy7lJvwuBitBlYHlsYxu2hZ1JWTBEyIkXu7xNGqoOup7qiGtWwVCCrAlxiMMbM8VuNLA2Us03iLUHMYz2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814926; c=relaxed/simple;
	bh=fyQwYGfpCTPfo5t1mrkZ6jKr3kA8pfK+w3A/LSeJaqI=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=EFYxLWiH9spPtLE1RTqTgo4R3TZ6IM8sk/68ReBwRyPYzIH+uCwzYd5EXBhwgnv9XVe+MNvGPmlm57trNCzC3Mx2W/81SzKIGiT2xjjLgBWzmlzoVnVKhSn17/o/VWaRKch4q43vPB2DdHgwoT0/6bvbVSnUZo6hMNpYMRsKH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=L0ZU+6Ki; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="L0ZU+6Ki"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Subject:From:To:MIME-Version:
	Date:Message-ID:Content-Transfer-Encoding:Reply-To:Cc:In-Reply-To:References;
	bh=RMVpTTIpHpZuATxhYhmbEG+iftgqkXmWdhg8mWUf0zU=; b=L0ZU+6Ki0qUJti7UXBISZ/LhA0
	3hg04Ermj93Zoeww+QWBZE2iqG8Xzq1FaNIWsAbsHUXkElqZH3WVXLFfYSasvCEp9ilh27so6bFIJ
	Pj5AF4eKjYgXgVNhT0YTOmvuZMzN8Cmk50C9RD4I0KXB6eFarYErktWCe+0SNXloWUcLCCAak1f5Z
	WjCF6MCL02sWNNbXP1J7H1mx1fYtH76PCxT2e7DzxEYX15ZuiE+6MunbL5lphbV8ZDGYnOO9g6hMi
	MIyMR//S+LXwss+aGqW+EPqOE35/i1xeux04VUQjHjYJBz7H91CeG0CBOd56d5qkWDetjbYmM4MmB
	aOGl0MeA==;
Received: from [63.135.74.212] (helo=[192.168.1.241])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdZPe-009nJn-KL
	for <linux-sparse@vger.kernel.org> ; Wed, 07 Jan 2026 19:41:46 +0000
Content-Type: multipart/mixed; boundary="------------g2cVKzvqn4i6DYTqoYhBm6vd"
Message-ID: <2943a1fd-1168-4043-bede-8f39cad4444b@codethink.co.uk>
Date: Wed, 7 Jan 2026 19:41:45 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-sparse@vger.kernel.org
From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: issue with _Static_assert and __builtin()s
Organization: Codethink Limited.
Sender: ben.dooks@codethink.co.uk

This is a multi-part message in MIME format.
--------------g2cVKzvqn4i6DYTqoYhBm6vd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

So I am looking at why the Linux kernel's check for nul characters
in strings is causing errors out of sparse.

EG:
drivers/md/dm.c:3813:1: error: bad constant expression
drivers/md/dm.c:3814:1: error: bad constant expression
drivers/md/dm.c:3816:1: error: bad constant expression
drivers/md/dm.c:3817:1: error: bad constant expression

I've tracked it down to the sizeof(str) - 1 == __builtin_strlen(str)
failing to be a good constant expression...

This is an example of the assert which isn't working:

_Static_assert(sizeof("moo") - 1 == __builtin_strlen("moo"), "nul!");

This does at least get past w/o warnings
_Static_assert(__builtin_types_compatible_p(int, int), "doh!");

I've had a go at updating builtin.c to deal with __builtin_strlen()
for a string constant (attached) but that's just changing the
output to "error: bad integer constant expression" so not sure
what I've missed here.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

--------------g2cVKzvqn4i6DYTqoYhBm6vd
Content-Type: text/x-patch; charset=UTF-8; name="initial-strlen.patch"
Content-Disposition: attachment; filename="initial-strlen.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2J1aWx0aW4uYyBiL2J1aWx0aW4uYwppbmRleCBlNDc1MTQ0NS4uZDdl
NTZiMzQgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4uYworKysgYi9idWlsdGluLmMKQEAgLTU5Niw2
ICs1OTYsNDkgQEAgc3RhdGljIHN0cnVjdCBzeW1ib2xfb3Agb2JqZWN0X3NpemVfb3AgPSB7
CiAJLmV4cGFuZCA9IGV4cGFuZF9vYmplY3Rfc2l6ZSwKIH07CiAKKyNpbmNsdWRlIDxzdHJp
bmcuaD4KK3N0YXRpYyBpbnQgZXhwYW5kX3N0cmxlbihzdHJ1Y3QgZXhwcmVzc2lvbiAqZXhw
ciwgaW50IGNvc3QpCit7CisJc3RydWN0IGV4cHJlc3Npb24gKmluaXQsICphcmcgPSBmaXJz
dF9leHByZXNzaW9uKGV4cHItPmFyZ3MpOworCXVuc2lnbmVkIGxvbmcgdmFsID0gMDsKKwor
CWlmICghYXJnKQorCQlyZXR1cm4gVU5TQUZFOwkvLyA/IG9rCisKKwlzd2l0Y2ggKGFyZy0+
dHlwZSkgeworCWNhc2UgRVhQUl9TVFJJTkc6CisJCS8vdG9kby8vCisJCWJyZWFrOworCWNh
c2UgRVhQUl9TWU1CT0w6CisJCWlmIChhcmctPnN5bWJvbC0+aWRlbnQpCisJCQlnb3RvIG5v
dF9saXRlcmFsOworCisJCWluaXQgPSBhcmctPnN5bWJvbC0+aW5pdGlhbGl6ZXI7CisJCWlm
ICghaW5pdCB8fCBpbml0LT50eXBlICE9IEVYUFJfU1RSSU5HKQorCQkJZ290byBub3RfbGl0
ZXJhbDsKKworCQl2YWwgPSBzdHJsZW4oaW5pdC0+c3RyaW5nLT5kYXRhKTsKKwkJYnJlYWs7
CisJZGVmYXVsdDoKKwkJZ290byBub3RfbGl0ZXJhbDsKKwkJYnJlYWs7CisJfQorCisJZXhw
ci0+dHlwZSA9IEVYUFJfVkFMVUU7CisJZXhwci0+ZmxhZ3MgfD0gQ0VGX1NFVF9JQ0U7CisJ
ZXhwci0+dmFsdWUgPSB2YWw7CisJZXhwci0+dGFpbnQgPSAwOworCXJldHVybiAwOworCitu
b3RfbGl0ZXJhbDoKKwlyZXR1cm4gVU5TQUZFOworfQorCisKK3N0YXRpYyBzdHJ1Y3Qgc3lt
Ym9sX29wIHN0cmxlbl9vcCA9IHsKKwkuZXhwYW5kID0gZXhwYW5kX3N0cmxlbiwKK307CisK
IC8qCiAgKiBCdWlsdGluIGZ1bmN0aW9ucwogICovCkBAIC03NzUsNyArODE4LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBidWlsdGluX2ZuIGJ1aWx0aW5zX2NvbW1vbltdID0gewogCXsg
Il9fYnVpbHRpbl9zdHJjcHkiLCAmc3RyaW5nX2N0eXBlLCAwLCB7ICZzdHJpbmdfY3R5cGUs
ICZjb25zdF9zdHJpbmdfY3R5cGUgfX0sCiAJeyAiX19idWlsdGluX3N0cmNzcG4iLCBzaXpl
X3RfY3R5cGUsIDAsIHsgJmNvbnN0X3N0cmluZ19jdHlwZSwgJmNvbnN0X3N0cmluZ19jdHlw
ZSB9fSwKIAl7ICJfX2J1aWx0aW5fc3RyZHVwIiwgJnN0cmluZ19jdHlwZSwgMCwgeyAmY29u
c3Rfc3RyaW5nX2N0eXBlIH19LAotCXsgIl9fYnVpbHRpbl9zdHJsZW4iLCBzaXplX3RfY3R5
cGUsIDAsIHsgJmNvbnN0X3N0cmluZ19jdHlwZSB9fSwKKwl7ICJfX2J1aWx0aW5fc3RybGVu
Iiwgc2l6ZV90X2N0eXBlLCAxLCB7ICZzdHJpbmdfY3R5cGUgIH0sIC5vcCA9ICZzdHJsZW5f
b3AgfSwKIAl7ICJfX2J1aWx0aW5fc3RybmNhc2VjbXAiLCAmaW50X2N0eXBlLCAwLCB7ICZj
b25zdF9zdHJpbmdfY3R5cGUsICZjb25zdF9zdHJpbmdfY3R5cGUsIHNpemVfdF9jdHlwZSB9
fSwKIAl7ICJfX2J1aWx0aW5fc3RybmNhdCIsICZzdHJpbmdfY3R5cGUsIDAsIHsgJnN0cmlu
Z19jdHlwZSwgJmNvbnN0X3N0cmluZ19jdHlwZSwgc2l6ZV90X2N0eXBlIH19LAogCXsgIl9f
YnVpbHRpbl9zdHJuY21wIiwgJmludF9jdHlwZSwgMCwgeyAmY29uc3Rfc3RyaW5nX2N0eXBl
LCAmY29uc3Rfc3RyaW5nX2N0eXBlLCBzaXplX3RfY3R5cGUgfX0sCg==

--------------g2cVKzvqn4i6DYTqoYhBm6vd--
