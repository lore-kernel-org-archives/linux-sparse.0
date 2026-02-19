Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECB34AB15
	for <linux-sparse@vger.kernel.org>; Thu, 19 Feb 2026 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520796; cv=pass; b=kwlxEfsf22SDJLVK1jPf3Yi/ChLcaDntyyBtXxSUG0p5tyHUVo/JRfb3R9KbWQifYwPx8nPdQIk5PrQfHmUlwEhJNewH99t8Uy1xakjVdBz2Wz3OjxOKFesHCKdCiB3GdDg0kz8tB45w70XfmiUKXQzrH6ifrr//VO5IMAZ0ljk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520796; c=relaxed/simple;
	bh=PDL3ADfTUjQJ9baIpgOVXBhOINqlaJdo+eD/uky5pRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs+8SpEu8SBDsL9u4G0PaW3vkodCdoMxTBMz4q/KGLtFWG7X3nh68MTY6SA2qmDb++Lht7tAkWr9MgWhGhlYUFsnikkCUo5ewsgRlY7Q4eizYOhpnxfFSkiE8utXM5JWI97KFOHoxqTsvPQlJOlEKknGZhjH7Y0i5Z8iIrzUyBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-797d3864d89so13124097b3.1
        for <linux-sparse@vger.kernel.org>; Thu, 19 Feb 2026 09:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771520795; cv=none;
        d=google.com; s=arc-20240605;
        b=WCbgQACtCVpc6CAyHJzg0UpMuFdQaHYpfADIHPXTIPhBitTGBEpFw1EQNf/l1dbUHo
         HwphXSfDYlyR29AFGKCS/LM+t/tftjaHApLuupKZiCE6P9SNKUc89zAoVGxHC4yqgFQz
         D/pm+zri1tLJdAmMqB6PEMRt7eZ9v9YeLeKdKlVJWcd0AKMC6/ja1ZDHej3UIJGhjTEv
         8ibHFKPwGGVCYrius19rX2O/H3Cqc4slDifamdt6HQqNXNXSfp4mhEFXgLTYTeKKqG0Y
         ts6hCUA3Z1oDzQEmOCiSqRJJQIzVGDkeDNuyH2ioyssitMv96IPp4WJXnl4sYu0LSLF1
         63qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PDL3ADfTUjQJ9baIpgOVXBhOINqlaJdo+eD/uky5pRg=;
        fh=HKjhsc9gNRxUKJFQtG0+OvPkzaNKN39eMIktiHE7EeU=;
        b=KGu3bo+wCpACuRemZqYnMcgE7fDciVplWH0NFrhYkSR3GOrO/oH3uHpJdEYjxl11P+
         of5zsBsbVqWpTHp1hsEQThSGWBFC3eF5sQuZnbdBBvnygI95IrmuRx8G1poym1OjJm7U
         cJGizlGr9pKNPduLlbsDntLWEq67p3GohfiKD5eeY0Dntk1T1A1o8UvRbtIotGc9iqTq
         7cJ96vHMeUiKOzhqNF4ErD7Jinpft3Gtv86YMzrQQczSVZ+DyrMw/TuksTKTNlZkLEVS
         5ayeexXpYsVH71qj2NinPX0Gn0F5d7+OO7LVAdoVC4sOAJ9wHHIFR7SSo/c8YcNJ0y3v
         HSOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520795; x=1772125595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PDL3ADfTUjQJ9baIpgOVXBhOINqlaJdo+eD/uky5pRg=;
        b=TUWtvcMVKULR9jjQCCsczEwRUBfsoTh0qAxb6IJDTAUNaY7MjaoTIuOGrZy+XiRz2X
         +oGL4r9K3ZFb3jUT+aSuUQHG/1tM8N2brZF9jn9E5HSiObEPgqNYLuLPyoQ/V39hwDFV
         eSTekcmgK8WRZ4xtiygrq3xpyvkOu3jd9y7H/zPYNm0lOBhPwJivkcaq7unRhcAvRzHW
         keD/2nrAwQxyskVNomZyYLDK5G/b+5obzZhkiqFPQuf/OOQVSfvQA/pDihumF+sFF9Rp
         dHdlQOB4AJHA0tsU1a2th+NybnEoct8fRF9d2pT7GKPF+aKtqYpodbAQ6G92qQ6o3Utg
         4eKw==
X-Forwarded-Encrypted: i=1; AJvYcCWhhHRVKio7Jh1Aiym8y38GM0w0JGCArOd1nKWdW32wz/Q4VpgthNiVxnivjYV26I2aP3mtUWRorg4L31Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzInE+2QA+h7FgHuxoDSlY2K1M1z9d+GYPK34bo0x5xvdomqHYj
	ZlYU/aHT4rujbvkKjnG5PQ913Y7Y7u+8NLe4TmZcsS6LVctVHQnsS1mZ1XUnAUvn/FodwDwG1aD
	FnxqJR7pKym0zeYYfqITe36aP5GtrU7n3XIZalomRNA==
X-Gm-Gg: AZuq6aLnTVOJkO3nwbvOqWvKk4uyRm0CjYjyx27DY0hN47eaB8IM+ZV0ErEXgY3+xq2
	ozzkcm5a6qj3IHzmXuy1Wk+Qas2FTwatDKXauClvc3y66tb3jwKP5nrSf5qgnwArzROjsP3D3iT
	67CCxvTklHvxCNgRMX/5mYyECxejwiLIomIFPZkO/ks7cjeKbiu+UGLcNg51dFJFhy+mQCX0mu/
	tyiFbPO0fXtgroIX8bsaiZVZtBSQ9MbOEtXeHwX07Fxs8RI11AFoCRIARTPsx4ISbtbrZ+gOFyr
	yUS7/1+ibJ8TSks9rEKV2RUw+zx8/EqdOlvoiQ==
X-Received: by 2002:a53:ac93:0:b0:64a:e3d7:58ac with SMTP id
 956f58d0204a3-64c21a442e4mr13833516d50.9.1771520794582; Thu, 19 Feb 2026
 09:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
 <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com> <aZdAxZR-c8PY_uEL@macos>
In-Reply-To: <aZdAxZR-c8PY_uEL@macos>
From: Chris Li <sparse@chrisli.org>
Date: Thu, 19 Feb 2026 09:06:23 -0800
X-Gm-Features: AZwV_QjdOnMgiLE4kypKeprfnuFYZTeLS_e2Pq8-K0baZPp_KSQ2fANM0QCJBe8
Message-ID: <CACePvbU9Dh-caC59+L7wicZF+3sMjc4NC0HEkp9cVa7qqdydow@mail.gmail.com>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant expression
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-sparse@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	"Luck, Tony" <tony.luck@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 9:00=E2=80=AFAM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
> Chris, Al,
>
> Can you please take a look? If Al patch is the correct approach, any
> chance you can send it and fix this?

I am asking in another thread should I pull Al's git repo instead.
There are a few good commits there.

Chris
