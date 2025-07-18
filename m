Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005F7D098
	for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879864; cv=none; b=OMeuOAjuONDBpLUCobWXyaFsmjMeazgmiRo00l92Qa9wgYZtWYfYr74i542tl3O8ch46qUeK99NoMkIsLHQh2SLTwncUMTyZ4l3sjkoilLdeICZf5g05CbSBpLEzAyqz4F+ONiTxlxfv2FHVe2NOisV1WlRc7LqqU6i9wb6cHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879864; c=relaxed/simple;
	bh=H40tep0Rv0U6gqMR0evT7Pj2Me2Gk77w4/2xIDdHb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePoRz6UzBYhMD1zYD3EsaJelY+dEW/BZ/CyOR//kNfwe3JkO56zi4aWLxIrr29tZ61c4H6JLf2QDInrP/aCk9zTc6pSKVtxX0CfMF59ScAn4KvCk37TDZriPAISMSrj6DFYHlC8JZN9Loau5mvNdo0azDbLwzgn2ra7LTlFZfbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YRl8Q0t4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YRl8Q0t4"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so4279402a12.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752879860; x=1753484660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=YRl8Q0t4or1G/gZltApuhrg+WIHIAZFVZ7DlG7rs8DJJD5+H0TnWEvgYUoxgFsgq13
         bGBgDOdtHoI8WJgY9sxPV+5hf1WLbJ8DlQr91KInMYRfVvosQwW8DyVoeOmxUvD/ELxC
         3lfFtID6ALq2dpM8P/YkJvWoJ+8MJTOEXh8Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879860; x=1753484660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=HYwOQFHl+XlVKK3or+quTdBLkuuiCrIOCmi8vDmZEAdfDInU2CW5+1dOpjx62SUvfQ
         YcGzfevsgikeh3oZfIBtp4O3TC5PBh0VpL2/oQi1t6OaxyJWdy4LpJGdw5D4hlSrpSS8
         ciLucJtihAH1NkxfELZM61kkcgh6yKTQ2shVveSLj+/loMMU+QWd2ImyZatAbnWEBrFt
         0IuBuoKfc77h6OMXDCrtlyINeUxjgq/EwVkURSPAl6IVzKm2fcm1QyOuen+2NMFg6aoV
         Jvbg3z1+Rd3IKtLeeCxTtoJprOCGYTouiCkEqVo2fkZ5KCTMNSS54Yt/ERVOWsVFB/Sk
         7T3g==
X-Forwarded-Encrypted: i=1; AJvYcCX5iiyNe6wcPBrvijLqtg5iDgYck1+w6TbX6UjlQX9I6skP+6Sdah0xPG27O5yHphgq7Z13kyYG5OzJxys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsww7x4kcMRGAt29J2XbfAW0ijbF0cReyaK8aO8jVgSIg8a+w
	8vseRpE9AKqc3h6gZyKXKGI8IndE57qZ3FPBGmVfperivbImG273R0A5gBRRujWIwfOufYcaNok
	aRzOmoJRQsg==
X-Gm-Gg: ASbGncvjYtVl01B94pB+JnOlAqPNhkCU13aIWkmlZqjKROpG4mDRv27EOuWKsnnQol/
	gI3TaE7RpfIshSEnagViN6A8r58o2TWzunTIEincHRWvb0sG1zUhe8jMQ4DFSouxprAnfsmBE54
	ReJs96/3bMxD8rAMqF9Uev62z0qUq3jDZtdGNEbllFAyTWiOK77OuH1X3E5TCEQwxbEj1zTSlG1
	nYGNcutWxOeUC1BmOuOFHYOHRtibH/ivfAEFU6S9rGduWieKr5RepqGjl31icL/Cj1fB/QpvQNr
	83ipmoNfyb8YBS9KO0i0RmQDtkzxBLjYNLbSX7MYAlq2EYhKo0iixL4HlycIFCiap91uPxZmLNF
	bIJ1zAHdmLnjlZnkaR+wPQgALw83WLeJzg/L0pACToTj6BlBhttPQQqaEFaxy/l/5lQDfre+6
X-Google-Smtp-Source: AGHT+IGFFPoJro1K0AdQA15LFzj+0XdT4jTGahwKLm/3oBhk57IsvPUgBxTbZ6pEI/Q25Ctaj23jFg==
X-Received: by 2002:a17:907:da3:b0:ae0:c976:cc84 with SMTP id a640c23a62f3a-ae9c9988bb3mr1267515366b.24.1752879859751;
        Fri, 18 Jul 2025 16:04:19 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2ec42sm199463766b.78.2025.07.18.16.04.19
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 16:04:19 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b45edf2303so2378969f8f.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 16:04:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUf7lg5PNSx7bEwkY9Jsgb03J6vxon6dbjSStxrX8s8Kma4FkazGHCbf91CJ13ykPioiGXrP474D4/ZQzM=@vger.kernel.org
X-Received: by 2002:a05:6402:510f:b0:607:6097:2faa with SMTP id
 4fb4d7f45d1cf-61281ebe074mr11282976a12.8.1752879516873; Fri, 18 Jul 2025
 15:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com> <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
In-Reply-To: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:58:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
X-Gm-Features: Ac12FXzEvcUEKGC31NKbtJTOHrioow4MaXx8l9_sG1eUWxP_1nSQ3xv-ujuWcb8
Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
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

On Fri, 18 Jul 2025 at 15:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And while looking at this, I think we have a similar mis-feature / bug
> on x86 too: the unsafe_put_user() macro does exactly that cast:
>
>   #define unsafe_put_user(x, ptr, label)  \
>         __put_user_size((__typeof__(*(ptr)))(x), ..
>
> and I think that cast is wrong.
>
> I wonder if it's actively hiding some issue with unsafe_put_user(), or
> if I'm just missing something.

... and I decided to try to look into it by just removing the cast.

And yes indeed, there's a reason for the cast - or at least it's
hiding problems:

arch/x86/kernel/signal_64.c:128:
        unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);

arch/x86/kernel/signal_64.c:188:
        unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);

arch/x86/kernel/signal_64.c:332:
        unsafe_put_user(restorer, (unsigned long __user
*)&frame->pretcode, Efault);

The one on line 188 at least makes some sense. The other ones are
literally hiding the fact that we explicitly cast things to the wrong
pointer.

I suspect it's just very old historical "we have been lazy and mixing
'unsigned long' and 'pointer value'" issues.

Oh well. None of these are actual *bugs*, they are more just ugly. And
the cast that is hiding this ugliness might be hiding other things.

Not worth the churn at least late in the release cycle, but one of
those "this might be worth cleaning up some day" issues.

              Linus
