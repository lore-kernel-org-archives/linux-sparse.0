Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ4UKM7z"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C9410F1
	for <linux-sparse@vger.kernel.org>; Fri,  1 Dec 2023 06:10:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54b450bd014so2508188a12.3
        for <linux-sparse@vger.kernel.org>; Fri, 01 Dec 2023 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701439847; x=1702044647; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/RCpB3un8WUrdwOP4Jdve+CRS/UkSnLxbVRKJtoTNo=;
        b=BJ4UKM7zIotwPBUvCJmfbWouZhXkwoPiHT2yKS4Tl33Xc/E6AHb6kMHLBtMqGUt+Jz
         Ym2FTc4Hy7qj9nWxQhR7Smnf2ZKTfb4tZHVpodb6tkucp8TGyoL0sdsTGrCbQh3TWMpx
         +vzm2u1C0A3V8KhjP6FpY3JsVmOiyZSHn8WDZ8ZhP5+1qRbFjX4QBlIAYrUGBwPlwDc/
         DOlf1tD3c192zRrbZNE8MlpXnrnbBjOpAnYiEbpbjGOBKdFrW1LP+oe7yHGxp5u1FGRx
         Nu9XvodT3OG7BqPCvFeCDybdBs4JNaWC4NjydnOzgg+dabfROl/P2cE1hCCgN7EzPSHl
         LcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701439847; x=1702044647;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/RCpB3un8WUrdwOP4Jdve+CRS/UkSnLxbVRKJtoTNo=;
        b=r1sHNibYAfqc6cv9SjOFyRfInKKQsto9OEJB8xFCBLu0e/5MMdJBbFsq/+cXPz4T6V
         GjML3ToP00Kw4a4npvgjjciwyWnpZpAsimj9fFIBPZeuG5uXqQEKCZI0uf5G/di+NM3S
         om2Cw2OscTDdgh8fCNGyplnCDnrVgpSru6GlqFrsuqBW4mFPhEKHc3xY3yn1nGk60Ce/
         yDGoL+QrEgbngtNLTasSL9fCxefB5ZO2H0lexWJs9QtMgFUUwy87lPiC+MQfh+COcX3v
         2/2VexgW+RbnONjmDAVNDdboOSumfsvhWQLoUqTS2oHpHpm6n91vly+cxyzG1kMK7sbq
         vsGA==
X-Gm-Message-State: AOJu0YwZI7WD0R0dyydf7w2bEdjJQbQjdE1qxQabpaeR354PvgPSBpN/
	Mp847o95W6X1udRL/GYeDZo+6bRtPjzgkI0cBDZMqcpk7Dw=
X-Google-Smtp-Source: AGHT+IGn/+nJUhxpQIeDzrNNXdbRoH/ZVCwmcTH8w1sO+ngaIVqkcDefpu9z+oMnOma7zuy5QpFKVVHx+x9FftVdzOg=
X-Received: by 2002:a50:cc8d:0:b0:54c:4837:8b6a with SMTP id
 q13-20020a50cc8d000000b0054c48378b6amr921982edi.56.1701439846592; Fri, 01 Dec
 2023 06:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310080853.UhMe5iWa-lkp@intel.com> <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
In-Reply-To: <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 1 Dec 2023 15:10:35 +0100
Message-ID: <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com>
Subject: sparse: Expected ) at end of cast operator, got __seg_gs
To: linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forwarded from linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, Dec 1, 2023 at 2:57=E2=80=AFPM
Subject: Re: [tip:x86/percpu 12/12]
arch/x86/include/asm/preempt.h:27:55: sparse: sparse: incompatible
types for operation (&):
To: kernel test robot <lkp@intel.com>
Cc: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
<x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Nadav Amit
<namit@vmware.com>


On Sun, Oct 8, 2023 at 2:43=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/p=
ercpu
> head:   ca4256348660cb2162668ec3d13d1f921d05374a
> commit: ca4256348660cb2162668ec3d13d1f921d05374a [12/12] x86/percpu: Use =
C for percpu read/write accessors
> config: x86_64-randconfig-122-20231007 (https://download.01.org/0day-ci/a=
rchive/20231008/202310080853.UhMe5iWa-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231008/202310080853.UhMe5iWa-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    kernel/bpf/percpu_freelist.c: note: in included file (through arch/x86=
/include/asm/preempt.h, include/linux/preempt.h, include/linux/spinlock.h, =
...):
>    arch/x86/include/asm/percpu.h:550:49: sparse: sparse: Expected ) at en=
d of cast operator
>    arch/x86/include/asm/percpu.h:550:49: sparse: sparse: got __seg_gs
>    arch/x86/include/asm/percpu.h:564:33: sparse: sparse: Expected ) at en=
d of cast operator
>    arch/x86/include/asm/percpu.h:564:33: sparse: sparse: got __seg_gs

sparse is too strict here. The following code is perfectly legal:

--cut here--
int __seg_gs foo;

int bar (int *pcp)
{
  return *(typeof (*pcp) __seg_gs *)(unsigned long)(pcp);
}
--cut here--

$ gcc -O2 -S -Wextra -Wall test.c
$
$ sparse test.c
test.c:1:14: error: Expected ; at end of declaration
test.c:1:14: error: got foo
test.c:5:26: error: Expected ) at end of cast operator
test.c:5:26: error: got __seg_gs
$

Uros.
