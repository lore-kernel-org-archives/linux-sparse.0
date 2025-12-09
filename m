Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693A202963
	for <linux-sparse@vger.kernel.org>; Tue,  9 Dec 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313278; cv=none; b=JLJQfQqnAbo8aZ75klR2sEmRKgVvR8ou6qJ6eXUeJzdCVGdnyiwOsQhvdLUOGeGSfnfsqaNBiMGuGLSyvF4moeKUONTQ75LCvaLw1CRBA6hY+sr58w4rIXSK9tKNPoNb5dfOtdsxKP5pwFxv27NMyHiWljJGXExA2PqL7wLiCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313278; c=relaxed/simple;
	bh=rd2xZtg1TUqhPE9MjX+asDiZUF22CLDQ+9AXCBYKRVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3W8LPoMPILLk2N1Fvxd+c/6skWqioDJbbbeYq0QUCC90YiQJaAMdz7/I4COi5H2/nAe5vm77UNNyle/QPMOIfgcaX93kFXXwQJmIMRG8yLfvlf17yOcgJIh/CuN8JFo6x0Pg5UA13vjFvuc26gJqd97+4ZWOS2FL+bQB09i8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S5Xjpdml; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S5Xjpdml"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b713c7096f9so920160866b.3
        for <linux-sparse@vger.kernel.org>; Tue, 09 Dec 2025 12:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765313275; x=1765918075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qFu6Gyyu/IjR2ufdMGg+lZtY71e20af3aIOCWzwQgQ=;
        b=S5XjpdmlDcSQFXEDK3Jvcjov7hK17zUDW3wJq254bsGtCOL8Q/bLzuDTufOMbZ7u+e
         wWneaIQltcOHG9B/Mk/xqr3nbW/ddrTBEU5NpeH7YPGZn0eevzL9JnFs6TUSsyUtIvGX
         +3JPD/evWldNMuaefJ/VyeVWaMNwvAhDo75Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313275; x=1765918075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qFu6Gyyu/IjR2ufdMGg+lZtY71e20af3aIOCWzwQgQ=;
        b=Xl1xP5nmpdj+C795KQV9pThLaqYjnT+GFBRU84Y0Am8bwVdM3VM+4/wCK7ezy0vOJ/
         5MtWED6aQ6y6S9KJRLPHOTcr2Jwoa2Bzd4fnVJfxmcJvy8a0e1pMj/smLP3CGTNH20pd
         OAksuV265Pnd5fUYMvX/iKLfb+yLmJglBrzfwYIQNOyaWGV5lQN397C+lVnx8bT5cdPK
         kO9dAhSD69CguLcKdMMu8UDZG62oX0s9c1EVPjduogOZauthvT0cmd/dbXgXeoBiIVA6
         vUbWlOnBT62hTLE7enePS3l1WtjjS+qdlKOUsMyERIHiXdfk2ohUQSK29f3pGvL/VOXc
         d6kg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ceaaIpXaroNl/f/jPCL6IcpIOLn4LoEfP/tmBkYMtZFc1mk92YVN/Z3Y29MeepikcUN3kx2mkb79riQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4BRx48rwnnF6NAIxTN5cjx7/CQNiTdSYlEyplFOAUu+0QQ3l
	VdXm0xGdnZ8QmqvRCs86bUifdnBQSIXQ30mzkWki4XEDlOp8YkK3ZjAj2ywWcfBkTQNshRgnrts
	KvF2lkYEhGQ==
X-Gm-Gg: ASbGncsblfx/6WglxUVd04fY5ZFeqHGS+qb+uT9hqW2ji2IwBPWYMYI+HOnVtYeZuMm
	4gWRAKmvETIlirlEby+JEXzEZg6bdmLmDET6sqQeRJrF0W5jyCpOr3wwX5lkjGPObq/inAYDHB2
	BkjxOYKZBlybJkqlioiC3x/zUd13SnIBviDie3IJnSIsNGZ95pZQiqOJCWo3P85O1+LvCB2tYdg
	G3+XF11ss8wmGPOy9IHoDsRHXS9GejFWjBHSjOz1STptProCHcROOxN8odFRN3p5cy556HlGRF3
	mtk0XOsnfAPFrjjyO5NWxI+NZktoHcMl1JK53ZLRKfoXsI5H8azUOKBs+TA+NDHI+ziUgaFiKhQ
	rTLUA5cxcKbcI7MFMExPxYVVHPbcvGdXARTuLqrwSGpax5f2qFJIYV08lVgOMQY4RnZ0tcI5bCz
	bOBj6F6THBO/Iyttyax4woVO88dboqc4gTF9kY86QlY/yJomzlB9Yd2HQw3WlDWUbjIvZuYTI=
X-Google-Smtp-Source: AGHT+IF/YEa77Oe15smdV5sJqsUPBO9lctdkn90shoj1iEwJkqViSRI3YeZjdQcMe+MbCgjuB+sgiQ==
X-Received: by 2002:a17:907:9608:b0:b76:b76e:112a with SMTP id a640c23a62f3a-b7a24305f73mr1373675066b.11.1765313274799;
        Tue, 09 Dec 2025 12:47:54 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49a7951sm1517836966b.49.2025.12.09.12.47.54
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 12:47:54 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b713c7096f9so920158166b.3
        for <linux-sparse@vger.kernel.org>; Tue, 09 Dec 2025 12:47:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqzDYUbmtVV/VJINKI+6913p1f6rfCqagaa1acDBAOGQtt22z3E04dydnHP2qDBsFsip5T6JtVrJQCoUU=@vger.kernel.org
X-Received: by 2002:a05:6402:27d2:b0:640:74f5:d9f6 with SMTP id
 4fb4d7f45d1cf-6496db38dccmr139683a12.25.1765312868177; Tue, 09 Dec 2025
 12:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <20251209002519.GT1712166@ZenIV>
 <43CDF85F-800F-449C-8CA6-F35BEC88E18E@zytor.com> <20251209032206.GU1712166@ZenIV>
 <87F4003B-5011-49EF-A807-CEA094EA0DAC@zytor.com> <20251209090707.GV1712166@ZenIV>
In-Reply-To: <20251209090707.GV1712166@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Dec 2025 05:40:51 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi=2errb29CgwA4eSaLCEojo2Jq1d3ptDhxANfcKPH9xw@mail.gmail.com>
X-Gm-Features: AQt7F2qPCXJihSB0EifxcMqIJwZJZTW_3j7hMQ2OwASD92TgZWMxviusY-ovH6E
Message-ID: <CAHk-=wi=2errb29CgwA4eSaLCEojo2Jq1d3ptDhxANfcKPH9xw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
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

On Tue, 9 Dec 2025 at 18:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, speaking of C23 fun that is supported by gcc 8, but not by sparse:
> __has_include().
>
> Linus?  Seeing that I'm touching pre-process.c anyway for the sake of
> __VA_OPT__, adding that thing ought to be reasonably easy

It sounds straightforward, and I'm certainly not going to object. I'm
not sure how much we'd want to use it in the kernel: it might make it
slightly easier to deal with various architectures and the "if the
architecture has this header, use it, otherwise use the generic
implementation" kinds of issues, but we do have fairly straightforward
solutions for that already in our build system ('generic-y' and
friends).

So I'm not convinced it really buys us anything - I suspect it's a lot
more useful in "normal" projects that have to deal with non-standard
system headers and possible lack of libraries etc etc. Our build
environment is so self-sufficient that it's not nearly the same issue
for the kernel.

              Linus
