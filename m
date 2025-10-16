Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471E34F497
	for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628678; cv=none; b=bJjjTQRwEEY9Sun/i6cbStIZJhS6YT0QcedXd+zYsm+Ex0dGGs7TyXilrVZV4isap0jjvcU8O2RIOcNN+jiBCK1VdQe0la8vr39fg8IrviOsX+JqVdLmvFWFRfyd+uhVWSyfMQR1pR2YaJofLlfKRnkUFWj5XY4zhjxSh1nddY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628678; c=relaxed/simple;
	bh=oPSZfzKjchNYvRXwAssEh2ZgT7gy1AGKMssbzfRlL30=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SpgXleRg1T/OGNxGnCZhLtM+IB0nCHXCH+m+qL02aSGA4OQjDlU3KlCj2JCbSwQfO2ERafsvBSH546Lrlie0laKKHlsuB6QOgMVoapRtU6Xn//iYMK2mwWK2jhUkigKVI8wRX4i7YICUzuTkzRHVDfR+of/Q+yErPjqrGeZ3GQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEashq5u; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEashq5u"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3652d7800a8so6471381fa.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760628674; x=1761233474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6zEJY2Jo6GYjvrL8Tx+v1H5Fwzv29sd1Ee19wVU+fQo=;
        b=KEashq5uS3tSyIJf3Tt4kmLGhxe0fFi6N0PwLt5wrxV46fN74nBIyK+7D2bnyQ0LhG
         OyrvO9wJErvs9jmrXXLU0aJYT60kZ6lsdn22tZvCs9YVrTw3Otke+1uNHLrC0+a4rFBx
         FlmqOWeMe+K3rzjYDTy3dhFUqu536kh+jcWxf26Lva7GpxvMtD0STK2MWBON0NBZQhW9
         dqRjJmY9dmoOZiA1GxWI+Z9F+BhTwxtifrUZoHnHW4xjDj7CG0yJqOasw9EP/29tlj7S
         LHi7XY9r/EHGGA5ObgwmaLMWvpW7va0HBvM2i8n/E/L2Ly+RxhFYGvJpsI+cjovdkiWK
         Xsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628674; x=1761233474;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zEJY2Jo6GYjvrL8Tx+v1H5Fwzv29sd1Ee19wVU+fQo=;
        b=FBw8D6QZxNBUfi7TzkEK7j2oEHOZX1gxKEWfNWajejVltNM7VZa+8xfa7VdwfT2RUc
         dfYxThkyOCv1RmOuvE63IhqPl0WFQQ9L4MEpklapaUrWcKi92+6HArQcQOkYl9NNrn8c
         kFZ6JR37tHQy51z6Rt4OGGudQJ5mOBEv2oP1FeH4xPsPnbiRQi3jpqG5lFuAoA8bWUcI
         qt7qJyXd1pjop7+PNiZJo/loso2pBOYx00FEh+JZSEuiFfZtruSJYywiO+9OcDoZ4n4i
         //8ekYw72zlOkQvqqpsJTkl9Z+uKseZJInyjip5YRLw6X2vH0VVdVG81rkTnOfT/Wid+
         vG4Q==
X-Gm-Message-State: AOJu0YzWqkt2nVKrCNFPhf+BSBtvBJIL0omWHWgqv3u2aCZEhHRfnfvR
	NnpJjsKB44jabZwiGxZQB2piGWjtmtcKtKqMMjNovqKMDxruH6DAsC/nxD6NbzRDM9+d9kXXP9e
	usj8hl/52d13VjmqOySACoCKdQTyJm3i/BzJQ2Ww=
X-Gm-Gg: ASbGnctyD9UBb68FT0sSoJy7XzoBGYmip42ww3Zb6Wjf7HEm6ohv78TxcIlcLdznEBy
	bacy43+8tipNye/vTytZ1E3nNxxDoR4pxEeFQOoUCX11d+MOtCFRrBRAw1U20lTEspq87Tnv707
	OeW228UxtYjWhrgQRlFT+QyFO1gErWnYroMMkf9pTMjzGMTsyb0cGR9FpEQhz7xdnxAS9S6A61L
	bpNMHPNzd0wG/X2gDdTkFijzlfU+JSL3NwQMpZ0LTUVTpI/ZGYQdLPv3eg8IHrgh21UZ2s=
X-Google-Smtp-Source: AGHT+IERTOivmnIpB4Dar3bVK9O8jkLBR2KoZZcdNzO+8v9IHJDew7JkzMuLzZKNWWNqeqcEe0i6UxdRMEnfjchni0k=
X-Received: by 2002:a2e:b8cb:0:b0:372:8e26:a4d4 with SMTP id
 38308e7fff4ca-37797a83656mr1986521fa.42.1760628673762; Thu, 16 Oct 2025
 08:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 16 Oct 2025 17:31:02 +0200
X-Gm-Features: AS18NWD6oW3gHw68NHtuVywjZPDrFb9Ne6pYE3mCvyM0pIc8H0K49gLYBqGL1Y4
Message-ID: <CAFULd4ZV6OiDZF8zknddrxPRTD5vhSQE6nEux4dr+2p1A7N6uA@mail.gmail.com>
Subject: typeof() preserves address space information
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Chris Li <sparse@chrisli.org>
Content-Type: text/plain; charset="UTF-8"

The following testcase:

--cut here--
#ifdef __CHECKER__
# define __seg_gs        __attribute__((address_space(__seg_gs)))
# define __seg_fs        __attribute__((address_space(__seg_fs)))
#endif

#define __read(var) (*(volatile typeof(var) *)&(var))

extern int __seg_gs m;
int foo (void);

int foo (void)
{
  return __read (m);
}
--cut here--

compiles with GCC (15+) without warnings, but sparse warns:

_.c:13:10: warning: cast removes address space '__seg_gs' of expression

typeof () operator should preserve all qualifiers (const, volatile,
__seg_gs, etc). OTOH, typeof_unqual () operator strips all qualifiers
and returns unqualified type of what typeof () returns. Please see
notes of [1].

[1] https://en.cppreference.com/w/c/language/typeof.html

Uros.
