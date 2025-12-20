Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1529DB64
	for <linux-sparse@vger.kernel.org>; Sat, 20 Dec 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766224928; cv=none; b=V3QxHNr8txz5IM2PkDLcV1vZOlauAKZYg1U+Rpm9C4QHUQLaRlX95CMVl2W0VYRuz8rhBfycEpqwRWSBL6cMQLZMHZwKspk/FgHX2ya6ICS//fbbaddbgAiKbJjLtXIFZOI3tLeTxjnFLrlWtDiGpzTPvmz2kmMqZ3GFeEwycnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766224928; c=relaxed/simple;
	bh=bxFgAEY81SjNvUJ+kxxs2m1wYC/4BSvGlgWSuaRMhJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fw1sdPa3NQEgWuRGJaBvQZpsK6dbTmTrGUq2jOKN9X+K3fM7yYYgDvftfZRUwNDLeYaSCRC0a/15PyNAhjwS8I6wzHgY9F1m/woly2PwSrzepojPQweZwmXg5nqw8Vu6NAQxlDnpM72OFYFB+xFzBUbGXgalmBS28yDNnWftJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em41QCIU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em41QCIU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso7740985e9.1
        for <linux-sparse@vger.kernel.org>; Sat, 20 Dec 2025 02:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766224924; x=1766829724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b6TgfZ4l4yfYsx0rUlhXwOOOgK1ZGgIr0RlxGtU3To=;
        b=em41QCIUfIpTaePp09bYqEG9fP0XivMmMT6qoKVHG8dQQ5lz21fOYZsasKdptPCM5S
         C0jbJFdWopKnJLWEt0Xz4910XxoiVB7j/Umhjo5OsvhOU6pKrqwKIL4cc6eGAlTflWd2
         0DRk13PDiDaGMLe/ZXkfR9FKmt2i5HRG+1/CRPqGUAJvsARDmg789ogFSMD8ts8XZ5Vf
         rVkguRxaKEB/ktO+1kZqll9fYw3sN7ZBU8Ibt957O1pQgp+nsBjP+RM3cuIxApD2eXle
         OcW8T6SYggyCZ2hJwQ4YDsgUygxCv7vm+SOiL0LYpqiG/SAD+Lx2qvJCxL10Hqxmkj8I
         h0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766224924; x=1766829724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6b6TgfZ4l4yfYsx0rUlhXwOOOgK1ZGgIr0RlxGtU3To=;
        b=EgztxHWxACJvYUIMFtUt1cRm8da1MQq+Dc9PJl8XrDeuKpoAp+SS8c8kkAQcJIO5hS
         obsxB0NRq3ZzxOZQn/zSBwJtAyWUuq3HhjciOd+XtvokiNMbbMBXkWvuUUSOkZ4t/ydX
         qSNrzjVIZe8ZRovggUNM4Y+kduvYSiEDx6udAlVCkwL0Jbb8Xkw+kFaxqkxf0gB4Qu4R
         KuDNqk7PeTboXEa04PeyU0xcsu4SXGF4dDuipyKghKbYMtl8T85DuP1PSVjHDTSkK4zE
         8nFv9jcGVrvSjOYJHmZukJrlvGc0Gx2BDjYaiRa24CfGZ3vBg1nF9LXlOatX8OD1WkpK
         UCcg==
X-Forwarded-Encrypted: i=1; AJvYcCVOoJM7y/w6Q0dManYxbVB7+BFH/deLnAl7C3hQdLo6rYjGv3iWz7GKBWJ2aCTZXF1Bs3GbcKXLkWht1BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjP5LP6qVNkLV6S66VrHrD9vjrYpKGMHyC38ddOoMkAC1Lij0
	DOeQ8uA5IY8jt1K8ORun+IQsE6gT1fxFQP5Tw8UXvXoiyGYdQ4r59uut
X-Gm-Gg: AY/fxX6S2TLbAHn++TR7IGmJey2tHRNu+6fizb6JKkHgHGPDIn7oGQ0/iatR7zz+hcL
	4dR97BBVayrOTrtE2VZKXyR+Bx/zmU2uMmIt+2L5zaqxLSOWGxkLt5UujKFi1a8hXBPgqPK0ukl
	Ui4xjeztAaEcy1lD68V+1acHddUD7CRVUX3OZ3EKEJKRJFyg9KNlUVftPiSD/JwKqxK4BKUPQ0/
	0YlyOlgu3ahQjmM2Amxnpiv1EOxA5W5mqCDAIIJP9QssacOTzLZDMUprVonqHgWSpbAm9eyOMoW
	eH61oNAN0bWTyqBTP0vq5O/jypFFNhycZD92jAQurSYgBKFkCFYHJ7a5zKdJN4xPf/3MIV4Enxz
	20jJOS2NrCf8sejFby2iuTJnQrO48gz48p/htsk/XDIRvZRgCMWAxCz85LO4SSq0K+VZ2Hvsht1
	Uwvn8i870OFpZQJBX8rCWTiVoADXXhKB8UjtW7/821/ksR6DVB//y4
X-Google-Smtp-Source: AGHT+IHQOJ0Ua+zWZlb0QPcZUUI/HtzVKK9z+yFIQMbNJiEgWc0RnGqXX7qQpeO5IWGkqcyJJpZw3A==
X-Received: by 2002:a05:600c:1d1d:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47d1958f9c5mr48722805e9.26.1766224923818;
        Sat, 20 Dec 2025 02:02:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab257asm9840402f8f.38.2025.12.20.02.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 02:02:03 -0800 (PST)
Date: Sat, 20 Dec 2025 10:02:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chris Mason
 <clm@fb.com>, David Sterba <dsterba@suse.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kbuild@vger.kernel.org,
 linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-btrfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/4] minmax: remove useless cast in __is_nonneg()
Message-ID: <20251220100201.26d9b0db@pumpkin>
In-Reply-To: <20251219-remove_wtype-limits-v2-4-2e92b3f566c5@kernel.org>
References: <20251219-remove_wtype-limits-v2-0-2e92b3f566c5@kernel.org>
	<20251219-remove_wtype-limits-v2-4-2e92b3f566c5@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 23:39:48 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

> The function like macro __is_nonneg() casts its argument to (long long)
> in an attempt to silence -Wtype-limits warnings on unsigned values.

nak.

The cast is needed for pointer types, not for -Wtype-limits.
which is why the '#if __SIZEOF_POINTER__ == __SIZEOF_LONG_LONG__'
test is there.

	David

> 
> But this workaround is incomplete as proven here:
> 
>   $ cat foo.c
>   #include <linux/minmax.h>
> 
>   int foo(unsigned int a)
>   {
>   	return __is_nonneg(a);
>   }
>   $ make CFLAGS_KERNEL="-Wtype-limits" foo.o
>     CALL    scripts/checksyscalls.sh
>     DESCEND objtool
>     INSTALL libsubcmd_headers
>     CC      foo.o
>   foo.c: In function 'foo':
>   ./include/linux/minmax.h:68:57: warning: comparison is always true due to limited range of data type [-Wtype-limits]
>      68 | #define __is_nonneg(ux) statically_true((long long)(ux) >= 0)
>         |                                                         ^~
>   ./include/linux/compiler.h:350:50: note: in definition of macro 'statically_true'
>     350 | #define statically_true(x) (__builtin_constant_p(x) && (x))
>         |                                                  ^
>   foo.c:5:16: note: in expansion of macro '__is_nonneg'
>       5 |         return __is_nonneg(a);
>         |                ^~~~~~~~~~~
>   ./include/linux/minmax.h:68:57: warning: comparison is always true due to limited range of data type [-Wtype-limits]
>      68 | #define __is_nonneg(ux) statically_true((long long)(ux) >= 0)
>         |                                                         ^~
>   ./include/linux/compiler.h:350:57: note: in definition of macro 'statically_true'
>     350 | #define statically_true(x) (__builtin_constant_p(x) && (x))
>         |                                                         ^
>   foo.c:5:16: note: in expansion of macro '__is_nonneg'
>       5 |         return __is_nonneg(a);
>         |                ^~~~~~~~~~~
> 
> And because -Wtype-limits is now globally disabled, such a workaround
> now becomes useless. Remove the __is_nonneg()'s cast and its related
> comment.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changelog:
> 
>   v1 -> v2: new patch
> ---
>  include/linux/minmax.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index a0158db54a04..3e2e3e539ba1 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -52,9 +52,6 @@
>  /*
>   * Check whether a signed value is always non-negative.
>   *
> - * A cast is needed to avoid any warnings from values that aren't signed
> - * integer types (in which case the result doesn't matter).
> - *
>   * On 64-bit any integer or pointer type can safely be cast to 'long long'.
>   * But on 32-bit we need to avoid warnings about casting pointers to integers
>   * of different sizes without truncating 64-bit values so 'long' or 'long long'
> @@ -65,7 +62,7 @@
>   * but they are handled by the !is_signed_type() case).
>   */
>  #if __SIZEOF_POINTER__ == __SIZEOF_LONG_LONG__
> -#define __is_nonneg(ux) statically_true((long long)(ux) >= 0)
> +#define __is_nonneg(ux) statically_true((ux) >= 0)
>  #else
>  #define __is_nonneg(ux) statically_true( \
>  	(typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL, 1L)))(ux) >= 0)
> 

