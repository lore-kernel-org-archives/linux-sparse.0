Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED42571A0
	for <linux-sparse@vger.kernel.org>; Tue,  9 Dec 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265184; cv=none; b=rpowkHs97IWAYcMbvthP1cSIoT+/bzj2SlsI1cRKZ0blOvtwP9JRuQHSrrem1svO6vCECcgogdxxZAyDXOTDTK3C3cuzH2FVBD595z2hABBl0LoySr97tgh70+ttb6YPSKtjDxu8oky8BPmP2adZGWWK0d566K8kTrjle8pO27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265184; c=relaxed/simple;
	bh=8nT8939qWUoJYlT2R7sKtRouAfpezWZVT5T0CEHq2FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8VMuAHSbyuEo0TWu1Q/V98nwIvzDL6803LEX0/JGXpwiuxqaIoHcwKfWQmZHizhxVXmFdZirBcpkrnv4ZwyPkDA82V8NglPb+TqUDZ8USl+8ye6Knb5C0euWmuyIjoa9pvXz2hi46m0JFydQheMeMLtNd2Yjjff/ZwwwQyGvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bLwkTlHc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bLwkTlHc"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b79af62d36bso209424066b.3
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2025 23:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765265180; x=1765869980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7QhMUSo0zLDlINi8GAqDQeQHdxTHsyz1r33NHLku5hM=;
        b=bLwkTlHcWQMBb8tY5U8TY+BoyY1bQaAgjOvn5Pb2tufZIWtWZX1vMsOlhsRD46FJui
         EbvQVXbNFzRR01zBOazf07qk/Z4GMDHRTd4Hz3K3qCHL3jVQg0WJ+cJzrNwa0OumUK5Y
         FpFusuE/Nm/EUhL1IdkhusVg94AygieSmpSbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765265180; x=1765869980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QhMUSo0zLDlINi8GAqDQeQHdxTHsyz1r33NHLku5hM=;
        b=kKodGrRCYruSlzIt/0P8pEvv/a5RAbTLR2Cpa8hwbtutkLL5xh0ucNbPju0Nsrxlza
         DmvQAlpzxCAjhbWh4liM+jhMjhg+ckG7/ytc2CU2XvCJOTqkVWfLcaSkoEec73biJd2u
         /K4I3xY2DMr3LD3xjEVfB6LJ/EMCLA0yweLZsldvp1Wfo9ZGe6KW7POf78w7yPP3GHH1
         ZV0IsaVfuEyBBWB0BLznd7Ug/YUmTz/2lzEzkxosBe2fIJqrRaUzIB+pc6JMPBQKeo8q
         kYs6NRDGebrb78hQ/3Yzht+EpTllXo++6u6lVII8sAngsiHfsZagmJJPpO0IAQG5gu0v
         Y7RA==
X-Forwarded-Encrypted: i=1; AJvYcCXtVFvHO6IDPgAJWCfauOOa2hirDFG+tHSUG4UD9hXcCmViS7ppAYEp4lznBdnAvLRlWM7eDbAIJQc/zFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOboBwZYdyldiGMH+67YhTp36Tu4vdHbj1bJBEWhK37VafEKS
	UAiz9be2bVxY8ce2qOFTfW8pRcesCVQ0E5NhkTXFIxByGsGt0F8tuxy1dz4p4qdLlMMoVOCmj5J
	gVUNs2PKJog==
X-Gm-Gg: ASbGncs1PNcV3ZLucsHPF8t3zY4CJESICEudrjTAOwDNRoAqsMFRp0YVmf0p0BPLzts
	AvgFfj3x+P0BqImW8efFqPXkE8mhMQC0pPqzKxZBY+kh1FnPMPiMlVU6OcZQcV2R9lALEagPbOW
	LpZC+u6ROU+Am/X8yKINPsoVl28qtcvW/Q/8NZcbmCdavRQ6N+coBL9xKn8iCvsBFWIIaAZorva
	9Nhx6r8QxzFcoiKiPiLeycyOUqgNCVTu0GbPkAOLMlXqI3swNtgZQKy25IzvZ7U3isTpMLMhwPu
	tzZ1gIKi93vpGaLyOHPjUfMNcddgHT/VIJ6REjP+klSFOmOGFRKFLFztpoVXTuQsuFXozHkHpss
	HQUlAtMBPhR5DtCAKQoWXSmjFHv/nvT5cejVqVfW2666sdfkh3w644e+iwNt3w1+Foky9BDvf6Y
	BtdYq3I3ScYBHUk8wBLO0vf80dayrCg3P2DVdOqUIU0x5Mg33EZg6phnNmGnrB
X-Google-Smtp-Source: AGHT+IGCS6avTZqu5iG5f0UdRKzgT0DngQoKd6HOb+nh3Ng01eXWhngK7pJI1WYls/X7GtWRQ0ceSQ==
X-Received: by 2002:a17:907:7ea5:b0:b73:6998:7bce with SMTP id a640c23a62f3a-b7a2476f98amr1084478866b.33.1765265179913;
        Mon, 08 Dec 2025 23:26:19 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2edd772sm12747328a12.12.2025.12.08.23.26.17
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 23:26:18 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so9046277a12.0
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2025 23:26:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhIZ0XDR44i98CmvmrUvqI2GALot5srQVMxF2QNbYESXdrZDm0TWsSjgzsJdi2b33snlZx9HrnO2MExdI=@vger.kernel.org
X-Received: by 2002:a05:6402:350b:b0:643:883a:2668 with SMTP id
 4fb4d7f45d1cf-6491a430019mr7384754a12.21.1765265177527; Mon, 08 Dec 2025
 23:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com>
In-Reply-To: <20251208235528.3670800-1-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 16:26:00 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiNMD7tCkYvVQMs1=omU9=J=zw_ryvtZ+A-sNR7MN2iuw@mail.gmail.com>
X-Gm-Features: AQt7F2pU3mtSVlk8xXoOHi4ywQ2NpA8rkmyzrskk-X7c-Gbp__mUx8NnR72v7NM
Message-ID: <CAHk-=wiNMD7tCkYvVQMs1=omU9=J=zw_ryvtZ+A-sNR7MN2iuw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
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

On Tue, 9 Dec 2025 at 08:57, H. Peter Anvin <hpa@zytor.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git
>
> for you to fetch changes up to branch auto-type-for-6.19

Oh, and as I was going to merge this, I noticed it's not signed.

Let's not break our perfect recent record of using proper signed tags.
when I know you have a pgp key and I even have it on my keyring.

Please?

              Linus
