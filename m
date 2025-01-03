Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85EA1B87E9
	for <linux-sparse@vger.kernel.org>; Fri,  3 Jan 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896107; cv=none; b=kNFlapUY7hQ0axaNGA8FDjaZDFufikkehvl8DFhHfrf+t/tsKfsShHpwHsiI7GQHupMdh2wZWh35ftkpR2h/VR/ZH8BmAM/0e43ser2y5iut8HY/yKt4aWl6hVSW2W/E4IBeVAPCX4roZ0Oj5FoSjztI2mK0yITHe1Z/24pY5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896107; c=relaxed/simple;
	bh=n/Lb1MC5YXbPQi/MvxoZMw34dEukKFqqg7Z7FZEyaWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUnG6+fGnelzitfX1d2rKbEOkhojUFEC2qdrWBR/nbMOa8s9UOWRy9WIqqevNiA6ojTPmJGlCYoOAmmTA+tETeezyjQR+iW5eQknDEx/jInJtiNQnx9q5eFx68Zy2aCaeCgaw10P9/9+S8Kfb0bySECv8P40wWQ2vv4mVQdC9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5187aa2c97dso4052258e0c.2
        for <linux-sparse@vger.kernel.org>; Fri, 03 Jan 2025 01:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735896098; x=1736500898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Thojfix4iWawRcqBh7qgVLXXAozIA058kz1GrMnIvc=;
        b=bjoVXy3WOCjGzcDjIJ9+AchVT/iBQChBGrmQcq2NjxjIs41y37rM1XyRqAhCm67MtA
         Sf/S3DzkzcWSU3GcqOx7Rz1VIFIfYKSPtnFA8JPQ3HXcoAojLEDi8MCKU/uGukAmrM4g
         DoW4EMXrodRQQUxGf2HW0E6kJcIib+62NCWI2Z4vzGhPnlOfMpqM98ouSGXnAbMcb0oA
         V3h3e7seqEn//MKEjb6uaCOv0jJU5pDYtFyxn9EuBYY9DxmxNbI61cN25t2KeVoTDS+Q
         K4UE1RJurnH49YVMVAs0BNysNT+QpTlYePgU84rcl8Sbucw/ZXGO9ujIoYwNT65xZ5eG
         5bJg==
X-Forwarded-Encrypted: i=1; AJvYcCUFb/ga/yqBw6Pgu+E8qGT4RsaurHkU1D8G2X3RUGc/gTmpqVgpXIKtuU05YcLu3aWRxbSS+gF1gKlmw9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2OA9p/XHAhRZpGbem/AwhvIA1RWAWnXyMmuS+X/dwY6JTyXVa
	LcJbbM7C7wDEg1RwISpnBcWDel/OVNKsnpIdIoHct5MomXqzto9WPsVEekUF
X-Gm-Gg: ASbGncsDorBfItBEHXQZoqcYdt2fd5QkR4ssvGU3KygQLDqT3b0NahsGooTrct1rUHY
	UgSK6imqxulrquMDUADjoZ2WuVKkgTOaAHOPcNPyUyU2utyC9eXlJDi1xext/BIWFucvJUFoCOD
	aU9kqkrzGfW8N7dyiGoMTrsqXdoS9kIoauDPnCl0xf4VfKxpRGjFGxQysFy+uowtyyotMg5obTc
	b/9eN+YtP41378zGMM9nr6Edb2LLfZ6Py/iapgG7qYMVKqOCU7A2KQ1tYyeJzLM1AIuvZamhj1D
	lk3VhMT0iAwcEI19AzBdXew=
X-Google-Smtp-Source: AGHT+IGv5VPsczcTuiFP0V1JLPWdHaXxnjsf/IyylQ44/3CIGXVafGv7pOC2Dr9T55qK1mg+4f7tfA==
X-Received: by 2002:a05:6102:5122:b0:4af:f892:e9f0 with SMTP id ada2fe7eead31-4b2cc387ca7mr38053796137.14.1735896098369;
        Fri, 03 Jan 2025 01:21:38 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf9d9b5bsm5290823137.18.2025.01.03.01.21.37
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 01:21:37 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5187aa2c97dso4052250e0c.2
        for <linux-sparse@vger.kernel.org>; Fri, 03 Jan 2025 01:21:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6W8IJ1TgZdf+E+x1XbifwaLDAOmJxsk4Jfx8YWT9XAcZw1wixRmCLcYlFwHLvis+hCzoAxpVW1G34nng=@vger.kernel.org
X-Received: by 2002:a05:6102:6e88:b0:4b2:cca8:88d0 with SMTP id
 ada2fe7eead31-4b2cca889d7mr31721757137.1.1735896097341; Fri, 03 Jan 2025
 01:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501030516.uZrwnuQQ-lkp@intel.com>
In-Reply-To: <202501030516.uZrwnuQQ-lkp@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Jan 2025 10:21:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW-DYPp_2nAaBdvgoa6Yr9et2cNS_260H-9H_CT4yEasw@mail.gmail.com>
Message-ID: <CAMuHMdW-DYPp_2nAaBdvgoa6Yr9et2cNS_260H-9H_CT4yEasw@mail.gmail.com>
Subject: Re: [geert-m68k:master 2/2] lib/muldi3.c:53:28: sparse: sparse: asm
 output is not an lvalue
To: kernel test robot <lkp@intel.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, oe-kbuild-all@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, 
	linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel test robot,

CC linux-sparse

On Thu, Jan 2, 2025 at 10:40=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
> First bad commit (maybe !=3D root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.=
git master
> head:   17810b1de0e9e5c1000cf8f5b4787ad930b0353e
> commit: e96424b86d5098f44279399b85551e0f84a1c9e9 [2/2] m68k: Use kernel's=
 generic muldi3 libgcc function
> config: m68k-randconfig-r122-20250101 (https://download.01.org/0day-ci/ar=
chive/20250103/202501030516.uZrwnuQQ-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20250103/202501030516=
.uZrwnuQQ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501030516.uZrwnuQQ-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> lib/muldi3.c:53:28: sparse: sparse: asm output is not an lvalue
> >> lib/muldi3.c:53:28: sparse: sparse: asm output is not an lvalue
> >> lib/muldi3.c:53:28: sparse: sparse: not addressable
> >> lib/muldi3.c:53:28: sparse: sparse: generating address of non-lvalue (=
11)
> >> lib/muldi3.c:53:28: sparse: sparse: generating address of non-lvalue (=
11)
>
> vim +53 lib/muldi3.c
>
> b35cd9884fa5d81 Palmer Dabbelt 2017-05-23  48
> b35cd9884fa5d81 Palmer Dabbelt 2017-05-23  49  long long notrace __muldi3=
(long long u, long long v)
> b35cd9884fa5d81 Palmer Dabbelt 2017-05-23  50  {
> b35cd9884fa5d81 Palmer Dabbelt 2017-05-23  51   const DWunion uu =3D {.ll=
 =3D u};
> b35cd9884fa5d81 Palmer Dabbelt 2017-05-23  52   const DWunion vv =3D {.ll=
 =3D v};
> b35cd9884fa5d81 Palmer Dabbelt 2017-05-23 @53   DWunion w =3D {.ll =3D __=
umulsidi3(uu.s.low, vv.s.low)};
>
> :::::: The code at line 53 was first introduced by commit
> :::::: b35cd9884fa5d81c9d5e7f57c9d03264ae2bd835 lib: Add shared copies of=
 some GCC library routines

Thanks for the report!

Comparing m68k to the other two architectures that use
GENERIC_LIB_MULDI3 (csky and xtensa), and to microblaze (which has
its own arch/microblaze/lib/muldi3.c), that don't trigger this error,
the difference is that m68k uses inline assembler in its umul_ppmm()
implementation. I don't see anything that's wrong with it, though.

Perhaps this is an issue with sparse?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
