Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9901799F
	for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879365; cv=none; b=m3+Ve1eUUcvrCUD6YU2v9yaD29PtOrqGmOzort+yaq7zwcSMg0jHZJuUNTqde1x2lIvHe4+ATVRnLy35fzpTHZJAHLSfmJU1M/BWuXmA1Rr4elBVRfaEi4lumVI5QwAMrtpN1t+PLGU3dGHq4XDf4tb0N0hNq5UpPjcHkDGYZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879365; c=relaxed/simple;
	bh=qo67utYF/ovAn2X4y/cKDIWgVFy2L9OSLb/CZy1qQmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePgQeiMmDMal2D70/C0qBzU8hh5Yoy+T42+wwaYt30mEwOfOMpdmNh7XeOm11Y899VZwXgX9lzcnGDLRmMdH/9A6nv24KrruWPE8/UDEGzwIFrKZCksegm4WJC3JS/IKy06HurgyrLs2YOe1NAlhSda2vfpD+9wyckCUL0EeLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZI6eqht2; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZI6eqht2"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55502821bd2so3250745e87.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752879361; x=1753484161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=ZI6eqht2CsoRk2oZKvIHFAH2QA+0J6BbparYfQPO5WZZwf4kZ0VB5KiyvHM5MRQctf
         pmRxXyOXym7uXMDnHPecGBo6XTWENqM5KaOHnlHjCC5x3FlgqQVIYTItMtEHSkEi9IQ0
         QZ6K0zqlE5a/nOg03t7TEL3hukK3uTGq5m5o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879361; x=1753484161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=gfKgaor6GQe4kPeU492aPuOKbQWKMye0pn+dezqMfIkq10AaUc9TZ57efNIyzp8FDz
         7NtnBOYhb+GNlxlW0Xn2sgIBK5PVGp7/FtVvWHc1ke1V74oyMWSbbTJUQhCeq+jVgUfx
         whBtGz1yQklhdJkjKpEoNvvL7+XQkqg/REnqhNR9nw0dT5dQUg2qvEsefK4SrMoHZMcQ
         im7xrKlNmWnfpZfkzYzFpBLNYiNiYxe5ktmYX7ZVDBycd3OigG0AFqBr0gPsfgpe0c+g
         WhUHfpTFBVdFH6e6sgTG+9KNVTSRKbhn0D/5zaHMaD+G/X3phmXB1V48OfDVy4Hz+E32
         dcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxaES0IXG/uZmv1dG3RPzBe9FnmgagC8kksWnCpwCfywO5O48i19T0/g9Zi+Hvdlyzl3ZeefZlyA9i/eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFI04B7i2RV/fjni1/HgJA5Oz9X5ejYopyw8Ac/UzTl9w5xIG
	ldCLfJa2WaNQ3IsKqqB5qs58sdBi/pupGQwTMLzSQ2sBdWBNTwqVCqU9fKDVc33by2EZjcYkkzv
	T6n0HfWBWzw==
X-Gm-Gg: ASbGncsnMQHPHxNCYc6aMH4NyvBTdzSYX8cVVdKhfSVRCMqhpkgd/ozYrEOFiijfTtY
	kT+4v7kG8CH2amLiPcYc35nnyM9GI3J+z7sF8o41j9lXebK2P/taxlV/dvS36Y3LrJx7rrQsQAO
	ONUnQdvRYAtApI1v23JJHyhZ6ZwP81aJgTQXxQ0NnXGuJ0J0t821ya9u8bsqTtlV6yVrFKoMGbA
	I2nEZldqKD4lNTT6VnN3j3bAPFLaFU+XhIR2C5pBZJqWzYt1aaX15pPUD76vvP3aJnornnl6Ypv
	QHVlbzz8FZY/+UjRMpUoPggmYQEwkn2Os+z03VAFIK7YypTklJq0x7WlOWJL6XCEeAvIlV6fOI0
	Y2eKx8bENY13f3kiq+/taJHsE+tIGjgfbw5/DOq/YXa3Lx20MYh1WXkmW2Gt8q2azEgieGogw
X-Google-Smtp-Source: AGHT+IF+Nj0lHNlkklI39OiK/hSvAS5cPkYiSrV+s1wOxQn2gveIOAqbxreBTdlnc3WzOHDgsnU4Og==
X-Received: by 2002:a05:6512:b17:b0:553:2bb2:789c with SMTP id 2adb3069b0e04-55a23f3f09dmr2828348e87.37.1752879361246;
        Fri, 18 Jul 2025 15:56:01 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31dadf33sm424055e87.214.2025.07.18.15.55.59
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:56:00 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55511c3e203so2453667e87.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 15:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLp8DqplFveaipk5yisV4dpGJwn6Vh+BVpXRtqOfo5GvLfHMyY6Jqhg5R1PK4Hwj6x+giaMpKmsOel45A=@vger.kernel.org
X-Received: by 2002:a05:6402:84d:b0:60c:3f77:3f44 with SMTP id
 4fb4d7f45d1cf-61285ba5366mr11281504a12.17.1752878941898; Fri, 18 Jul 2025
 15:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:48:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
X-Gm-Features: Ac12FXwPQm0wFuMqO4T5e7rkg71dcrU60Bx64WOT68AUbiGf34w2BtStF_AEh5c
Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 14:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > -       __auto_type __pu_ptr = (ptr);                                   \
> > +       auto __pu_ptr = (ptr);                                  \
> >         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \
>
> But that second case obviously is exactly the "auto type" case, just
> written using __typeof__.

Actually, looking at it, I actually think the NIOS2 header is a bit
buggy here, exactly because it should *not* have that cast to force
the types the same.

It's the exact same situation that on x86 is inside
do_put_user_call(), and on x86 uses that

        __typeof__(*(ptr)) __x = (x); /* eval x once */

pattern instead: we don't want a cast, because we actually want just
the implicit type conversions, and a warning if the types aren't
compatible. Writing things to user space is still supposed to catch
type safety issues.

So having that '(typeof(*__pu_ptr))' cast of the value of '(x)' is
actually wrong, because it will silently (for example) convert a
pointer into a 'unsigned long' or vice versa, and __put_user() just
shouldn't do that.

If the user access is to a 'unsigned long __user *' location, the
kernel shouldn't be writing pointers into it.

Do we care? No. This is obviously nios2-specific, and the x86 version
will catch any generic mis-uses where somebody would try to
'put_user()' the wrong type.

And any "auto" conversion wouldn't change the bug anyway. But I
thought I'd mention it since it started bothering me and I went and
looked closer at that case I quoted.

And while looking at this, I think we have a similar mis-feature / bug
on x86 too: the unsafe_put_user() macro does exactly that cast:

  #define unsafe_put_user(x, ptr, label)  \
        __put_user_size((__typeof__(*(ptr)))(x), ..

and I think that cast is wrong.

I wonder if it's actively hiding some issue with unsafe_put_user(), or
if I'm just missing something.

            Linus
