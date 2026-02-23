Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C330BBA9
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865058; cv=none; b=D81pcYDi0/UOT+/g1M1WjeYwi2/HiL1fviLTvHea6vGeKbqyq0AFqmhndYYhfvw3mxCr+MgwDYj80b/8ChvxansL615V0QNgZB+4EOgTtTL8y/QoEyd5Zmt8Wu9vUZS0ma4FUHLW6grdiRmvmwYvT2wQd2UpWKKLPOQKlwyWlKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865058; c=relaxed/simple;
	bh=eWgr/RGtkzXrtG+mfTv7JJCcgbWqYMOQLlPhaP2C7bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldWKO4knBget4E6MpmqRXjEaaYGQNE8nReM1jbt4KbVaWgrTcF2QAJmX6nVhKHZB4QU6/daiT/8x976gBQXUeI7WfO2gpHxnOhkCisLtn6dBDI0fDxjOie5aPiFpyQII9BFG2D7VXnm7I5Ia7t0jszjR4j3dC6ssrFFp1kXZyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hQL4w6SU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hQL4w6SU"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b886fc047d5so727678566b.3
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 08:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771865055; x=1772469855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJqnxOoe2HI1jPaa243q+jQVH6M4G1Nxe5w8r/k0IM8=;
        b=hQL4w6SUoYf5DRy3K6JjktGq68oi1zAKbqctnxyCgIfoVbEV9DDSpwdNheGZMGhi11
         vl7SHobXdtXtR0FZzeNCBeuH/2tZxEQ/M3m/E/NxlzSkZYKWt++detasRrv7AansNUlf
         WyXqgxQPl/BEKGHqf/3eqdGz7rf63p4vEJRus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865055; x=1772469855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJqnxOoe2HI1jPaa243q+jQVH6M4G1Nxe5w8r/k0IM8=;
        b=roGrGIL+pUJgJUV7eecjeQxknxF/LRZpwC9mJKybl9TFFMxp31gCi6j9PZ6FIO/xMk
         wCGlE/fU0Id6eRH4Etibere7Q1ilOZ/V/Qd3iRmt1Bc5pvyYOizdVlyl9RY5QU+H9wGy
         hslxdDhauYwSLe/lT6q9XuZqXQlOO616fMAP6owMhEpc+X1dWB7zV97Pgxtrrqtxred8
         9PPyBCypywDDgHkeXDovnRSnRNJC00PBxDg1qkS8ov64SMbqxe8LHQ4pkDvJ4DEneIvi
         Vx5aJ1DAwQqYMRvTzoVnfeHwjTnCd8JZkl5p5v876K+I4XK21AIMph4GeL1mTp1LK6n8
         4YEw==
X-Gm-Message-State: AOJu0YzaYUm+gNUWxUe5uTqwZA8JeXi6eznX5X/LVClwSmSEdK95sblf
	4SUYPEFapIcnr0y3bQl4PGyxDfAv0XpL/I23lbyB86blgaQ4/Vit0fP52fOFhBHAKOSddZQY970
	pknC2iSg=
X-Gm-Gg: AZuq6aL4u77FDFxtIwhT3j3HQ/cUnXHP8II+lFivoG6XKg7dh6lPAlUeArBpcgx1tQZ
	XRHId+08G+ezNOv4himHUi2swbtJRb+P0KQHKcG3Sd2VLx/gCJeZYWkKNu7QaKUfk2AvE2w0mHE
	JmtR74LO3aKau6zndORK2jdl1Vu/GOlM8dClRFV1dyIpwoPM347+GH1Ghl2XA7b7HSajY1QUxsi
	jbzCMl1J93+adNZ0O35tJgtXf+Wk733mHfzLgbG5xFzYoQ99lqzYBn27He+LU9QQR9o/otFXhqO
	K+z1OWSvx6oNgzunP1KdB5El/Gnzy6tYbrXL3AX6uy9Qqk8TiDYEZn2iiaRMayKyrWjV82gtrbR
	4HHg+tgw/eHfCShhTbUBJzdrZIrUVtKHxpTl6jhYP4MSmZ5G6K4DO/ZTFWnx7m/7NjA4fvnXsFs
	mHV+QuaGqgHkVArjFL/fKo3Hvr+94l1woq4mfcluRug5sSuwBDZF3yfSX/SNVZ9MNKDFXXa2mu
X-Received: by 2002:a17:906:209c:b0:b8f:abff:9ce7 with SMTP id a640c23a62f3a-b9081b402f1mr333810766b.32.1771865055065;
        Mon, 23 Feb 2026 08:44:15 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9ab03csm2772666a12.11.2026.02.23.08.44.14
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:44:14 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f97c626aaso631021666b.2
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 08:44:14 -0800 (PST)
X-Received: by 2002:a17:907:1c91:b0:b8f:a34b:3d5 with SMTP id
 a640c23a62f3a-b9081954727mr602961866b.6.1771865054095; Mon, 23 Feb 2026
 08:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174fb380-6711-4305-b857-4b1ae86c74de@codethink.co.uk> <54d24dbb-eec2-4759-970c-4d7d3e48e6df@codethink.co.uk>
In-Reply-To: <54d24dbb-eec2-4759-970c-4d7d3e48e6df@codethink.co.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Feb 2026 08:43:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijD-giccF6sJ+BdJpGDX9kPEUT6kryaQG0GRyJ3QQwng@mail.gmail.com>
X-Gm-Features: AaiRm53GSIc4q0avAyCQL8i8naN58T9OYB6YMHki2BSX1OU0t5tXWzev-KtIblo
Message-ID: <CAHk-=wijD-giccF6sJ+BdJpGDX9kPEUT6kryaQG0GRyJ3QQwng@mail.gmail.com>
Subject: Re: hang with current sparse with upstream linux arm64 build
To: Ben Dooks <ben.dooks@codethink.co.uk>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sparse@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000240419064b807b3e"

--000000000000240419064b807b3e
Content-Type: text/plain; charset="UTF-8"

[ I should read all my emails before answering them, but I get too
much, so here's a second answer just to make sure Ben and Richard see
my first one in case they don't read the mailing list religiously ]

On Mon, 23 Feb 2026 at 06:08, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
> So currently it seems to be hanging when checking drivers/clk/clk.c
> doing the following.
>
> $ make C=1 drivers/clk/clk.o
>
> This is working under v6.19 and not under v7.0-rc1
>
> The git bisect is pointing to commit e19e1b480ac7 ("add default_gfp()
> helper macro and use it in the new *alloc_obj() helpers"

So I think sparse should learn __VA_OPT__, but in the meantime, does
this attached kernel patch fix it for you?

It seems to work in my tree, but I haven't actually done anything but
a very quick build test.

               Linus

--000000000000240419064b807b3e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mlzen4vz0>
X-Attachment-Id: f_mlzen4vz0

IGluY2x1ZGUvbGludXgvZ2ZwLmggfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9nZnAuaCBi
L2luY2x1ZGUvbGludXgvZ2ZwLmgKaW5kZXggMmIzMGEwNTI5ZDQ4Li45MDUzNmIyYmM0MmUgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZ2ZwLmgKKysrIGIvaW5jbHVkZS9saW51eC9nZnAuaApA
QCAtMTQsOCArMTQsOCBAQCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Q7CiBzdHJ1Y3QgbWVtcG9saWN5
OwogCiAvKiBIZWxwZXIgbWFjcm8gdG8gYXZvaWQgZ2ZwIGZsYWdzIGlmIHRoZXkgYXJlIHRoZSBk
ZWZhdWx0IG9uZSAqLwotI2RlZmluZSBfX2RlZmF1bHRfZ2ZwKGEsLi4uKSBhCi0jZGVmaW5lIGRl
ZmF1bHRfZ2ZwKC4uLikgX19kZWZhdWx0X2dmcChfX1ZBX0FSR1NfXyBfX1ZBX09QVF9fKCwpIEdG
UF9LRVJORUwpCisjZGVmaW5lIF9fZGVmYXVsdF9nZnAoYSxiLC4uLikgYgorI2RlZmluZSBkZWZh
dWx0X2dmcCguLi4pIF9fZGVmYXVsdF9nZnAoLCMjX19WQV9BUkdTX18sR0ZQX0tFUk5FTCkKIAog
LyogQ29udmVydCBHRlAgZmxhZ3MgdG8gdGhlaXIgY29ycmVzcG9uZGluZyBtaWdyYXRlIHR5cGUg
Ki8KICNkZWZpbmUgR0ZQX01PVkFCTEVfTUFTSyAoX19HRlBfUkVDTEFJTUFCTEV8X19HRlBfTU9W
QUJMRSkK
--000000000000240419064b807b3e--
