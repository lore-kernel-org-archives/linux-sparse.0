Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2797E105
	for <linux-sparse@vger.kernel.org>; Mon, 19 Jan 2026 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768782231; cv=pass; b=GhsJxqa8MFeD9xDqYi/GdzpMZ9wBOeJhaYsbWTcTOgk8AcO6qsDbhPs4CHkntKWYy4Dfn/F24zDR6x6LRPR+Csg+WZT7HJ63H/GIY6pMmgoI+bI9fMsHMgw9QlI0A1mhClWdt07+OKdBUzetq+WPrLMIIywKQ/V2xkR30CtcCxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768782231; c=relaxed/simple;
	bh=cczXCbEl6ic2qAZTj3GHz09k+fmTgUaHALIpCgpyCX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6jiDO0dOSQURDFsYqi8Ij8vow35eAwpHfMXYoJ8RU1xXChn2A2UW8N1XTMvp0PeTxaNTE8Aa88s2DpaQkif3paJBg0xNSHGOLcpCDlkL2K+kEu6cFzoyljganyqToeaYpnUEDMbOXyRff5xrzlN+FizAFHmrJqB4ZmdDYWk7TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fb6c7874cso39826167b3.0
        for <linux-sparse@vger.kernel.org>; Sun, 18 Jan 2026 16:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768782229; cv=none;
        d=google.com; s=arc-20240605;
        b=aPiOBJ+C3Vc+qax2aymp7kewVAjqC0K3ZbSZP79IWIH9X597JMamSxc4vFd1wErV7S
         cImZAGoJosYolyDJm8I0EDGA2eDY9qwg2MgrraCLkKJJoAgysReSCAacF48vEWZppS3z
         eonEx3+C2maW4VETcYfM/0ondygCDu86QI3oqqLbFkgumdBWarW71OPGKpXXwJgPQqnL
         DKq8IV0DWrxVFNH3i1Bg1WVpcv6wF4r0Jaoo0ynr9luzMnX4fViTjB3nvZW8zJEXGXwW
         0c530ignSV7XeLY7b+Mi/yWA9hGSIpOupy3VTVWPoFluK3Qb3NRxJHlWoKb2rxJ+USp6
         +daQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=O3k5XIQCw098e8R541xcDqT9F1VvvibeTB+DgmFIDuE=;
        fh=SPeZE/GHT3KwjoLRJ34R4QjTHTyhgqLxZzeb/asEbR4=;
        b=EWd5Hy45aDl4hIaBHT7vhfeUVFso2BTYBC96PhtdtHdK9ZSe+7nq9y34oNh/NH5k5U
         94mr8VUUvgfsU/VNh57jlRj/+gSrY7XGTOkKqCSaxOvXM1sdzywe65vS5gm28SAJ5SFG
         QFmQiBIGwYtpUr08LruEzKuIgveg9ECEIzQ1pQ/tmBkZOazAnmBzFVIibmOvlYFYVoKL
         9wXjf9ummefRVjRRVqTEV5HeFS9JEIRex51j2jDdEkzvJepmPDLYGzacxIuVLALj2CLz
         t01pCGiO3Vx60+1Kj1rpcHvatoCCCa0qQq8ei8DgGnLy8Krp5SM4Vl/B2o+UczKuTMrJ
         6O8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768782229; x=1769387029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3k5XIQCw098e8R541xcDqT9F1VvvibeTB+DgmFIDuE=;
        b=uUx8mgUlDRyeWfYASo52Su8mvLRRrihbrhxLN8j627oiVHscQ8P5cYCtOy+y7YDi67
         35CC4zipn4SeOj9fNFY18JZInO10veiguzwEIBW5VVWzVTw24Ui/lVqYipOShyGQxcQX
         S7ldEOdU39e91v2HwZcM1uE5h8Gq1NaUVXBI1moRfp38Z+Dt9RBAEB/eigeQ8WndPDd3
         XvAtCxkMCZgNMCFx3jAtY0kdbb/mdIvAJINpVIRnySzzfuVbY7AOKslQ6gKSZFCgMAE9
         8yBYcC+8oKHz57AXJ7GtLr7YuHMUvx0VN+0+TlRpvJXW6H8JdqHpBMD1Yz2GRsBItGbV
         2K1g==
X-Forwarded-Encrypted: i=1; AJvYcCUNSuTxEi+0nsCmcEbgftSWModWdSC4ydBEjSfCnJnJ12G9QOKSngHopUrRGFfBn2T9C8CfDVJz2wshJLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1afhm/mJ4PTHavPxmrAqHzRoHwWXe8BXZWS9M+TbSaxiW51HS
	FLMV7ohR4xCDEQh6mJV3d5Z1C5+qtM1WP7fHnpHZKlq1jlXe3aa0qH736NQslBlsaHAkUV+N4VH
	Aeq+fY0idqtjRz2+FkU0Ab+BNbakrBneI6n3QNGMPhA==
X-Gm-Gg: AZuq6aL53RzzpxKedvDaxf1qSmVx/yeRpREV9i6qiMg6Bw0Au1rOpW50urL5l6K+f8Q
	UQ1WTJW8pbZOnIqIdoyMu3JbVEAd6o3ptjAVFgXpLYfKM/GKWUywdmuFzbsWb201kYWuRbAM/FY
	1VGDSAk6dEKcJTCyb7MmBtT1ugF1q8tndi5J2cH3mvDn1rXQ5tzRBye4vANe565EZcJezzU+FZY
	mJD5pDyGZLqVKygiXPE+nnGImKa5P9951CrBGD55H+yoXj8h4yv4ocp1VEMJ7c76QiJ4X/4vmhO
	3xULT+UGdQj69w2xTWC9yCKW1IOC2WIyWspW
X-Received: by 2002:a05:690c:6184:b0:78f:9b43:7dc9 with SMTP id
 00721157ae682-793c6886dfcmr67398377b3.70.1768782228944; Sun, 18 Jan 2026
 16:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aULJmGi8yib_XH0P@redhat.com> <CACePvbW2OybP7P-Vk+pa23SqA0+R0i8=20TiQMq99PvNAYJ8GA@mail.gmail.com>
 <aWuagcDh53AQxEmw@redhat.com> <aWu5g1VkGe0ktRaW@redhat.com>
In-Reply-To: <aWu5g1VkGe0ktRaW@redhat.com>
From: Chris Li <sparse@chrisli.org>
Date: Sun, 18 Jan 2026 16:23:37 -0800
X-Gm-Features: AZwV_QiKBz-mNjBtz5JDiMhmQiFVHhET2FLYGl_AIKze1szNGYcobPeLqT2MBpg
Message-ID: <CACePvbXb+EJ9tdq=E8pw3uC-fjYp4CgQ27GqLwEgirWJiMVU6g@mail.gmail.com>
Subject: Re: [PATCH] sparse/pre-process: introduce "dissect_mode" option to
 fix dissect/semind
To: Oleg Nesterov <oleg@redhat.com>
Cc: Luc Van Oostenryck <lucvoo@kernel.org>, Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 8:32=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/17, Oleg Nesterov wrote:
> >
> > Agreed! This was my plan B ;)
> >
> > With this change
> >
> >       -               if (!dissect_mode) {
> >       +               if (preprocess_only) {
> >
> > make check reports 2 failures
> >
> >       -parsing/attr-cleanup.c:10:17: error: argument is not an identifi=
er
> >       +parsing/attr-cleanup.c:10:27: error: argument is not an identifi=
er
> >
> >       -sizeof-void.c:20:14: warning: expression using sizeof(void)
> >       +sizeof-void.c:20:27: warning: expression using sizeof(void)
> >
> > but the new positions look more correct.
> >
> > However. I didn't dare to send this patch because other warnings from
> > sizeof-void.c still blame the column 14, this looks inconsistent...
> > But perhaps we don't really care?
>
> On a 2nd thought...
>
> Unlike other warnings, this one (sizeof-void.c:20:27) refers to the
> inner "sizeof *ptr", so I think that this patch fixes the reported
> position. So yes, I think we don't care even if the new column =3D=3D 27
> differs from other warnings.
>
> What do you think?

I would just update the checker to have the new expected value
matching what new pos so validation can pass without errors.

Chris
