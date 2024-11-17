Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFDD1DB36B
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731884307; cv=none; b=B6HlWR7Qn1kRAP0lqH3ye42QCPvbYqzJiJUlAllHA7ydCqh74ahRv3ntK+X2L/VlX3iMRdSjk8mL4ZjIAjTitmEZcPLQQVBjYKpsblCRq2Dp3NKzy06+GurB7dY0CiIuc/yy56276LJUu40roCA3LNpZ6RlWyWvTSrZ+YJiiq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731884307; c=relaxed/simple;
	bh=EiVbVsi+3KRPH1RlO/UqhhebmUP6+aP3L6Bqgv1bwW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ktmm4p9FAHCi3R9d+RNHVRIsIAR1ralC1fvuQCH+CJvtUNHpY2M53iW+Q9R9YDBiprNrKcqsr6bNPG1NagNChM2wX7DgxOYl/Y93r6WTljDI7AlHd3alvzQMslLvqukhR4AUnc8vS2G/Ckm1ouuBFCyonWeG/LTPDbG4x4U3ZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G6wg8/Vh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G6wg8/Vh"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so135850666b.3
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 14:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731884303; x=1732489103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzkeKdhEDg8y8yiwaJERZ7qd5zIqnzWCTyWLEoroQ78=;
        b=G6wg8/Vhe0PNb3WyAqiFA8U4tA5/ZKgcaXWtTyB/Ef2j1FJPGMX294xh84HhEbk5SA
         B9Rfe6ddQqAXh+i/nYej7Fj2yfd05XERx3CbApUxlyT1F3tRwlcyyvXYMQ46DfZ/d4tI
         yrtldBTzzxdFC0cAJ72SVfB2Fklo6Py2Jks7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731884303; x=1732489103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzkeKdhEDg8y8yiwaJERZ7qd5zIqnzWCTyWLEoroQ78=;
        b=lPLE8a320+taXziTrg2Qw8BvQSW8WYBHEaabVO4O5tXj2XTqJ+MYlGCQXasB6gbT1h
         mlm2UYc/yYkrX2J0yyIGB9Bft7xAKTYFbFwcowzL1RgbfLjNCLy1m0Rm8UYyGcrGQv4C
         dWyg79+7f2T+SsVA8oWNSQ0rLTLvDGOZSwLqRyzh3LjBSj8JFRba2f9LumZVm+cuZ7uu
         S/voi7fudwX55SeShkZqxhIe7IuwpmlhoZe5wUZj7p0grIghMjjM6KZK5Zy9UsfQVfjQ
         mTMT0Hbu+mOwKnNXa4tyg6Kl8sojqAFbKSp1GnvbBJIJ55lSY/FxjwZBlM8Lmr6Oc2gU
         iMAg==
X-Forwarded-Encrypted: i=1; AJvYcCWTPEuiEQlSXkOOFsi1i+FTfpgROVxFzifIudNtQk5oHKBZwBUNwtBIenhh7/fC4AwPY0Hxw3fWRBfwEtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaewCFVVa7iCCQ3Nh2AVTdAHF74Fnv/kuuZXCAjpV5wFCQovZe
	f6KRVXr9nTR3nTUFijSgBsMZcBUYlFhCNBDiW3bUaD4gJZwgNASDVcYNrBAZHOuzdhOTZ9IuY8C
	Os+F2Hg==
X-Google-Smtp-Source: AGHT+IEG7l/XnKSA3jEUbkn1YPVORWYNi78L03gx23iCCTucReE7CPEr04GUhgcJcpPQ/+W3AFm6hw==
X-Received: by 2002:a05:6402:34cd:b0:5cf:c0ba:ecc5 with SMTP id 4fb4d7f45d1cf-5cfc0bb26c1mr4467386a12.4.1731884303420;
        Sun, 17 Nov 2024 14:58:23 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043e75sm462845466b.153.2024.11.17.14.58.21
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 14:58:21 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316cce103dso22115645e9.3
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 14:58:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsMSrQeAKM/3HfIjuT7RjvIxwx0sRJjea6hBCwPZhg8ug6JXHXcg0efyJPHJARZTOYHfMuUJVdm1vopuQ=@vger.kernel.org
X-Received: by 2002:a05:6000:1849:b0:382:440e:4e86 with SMTP id
 ffacd0b85a97d-382440e513bmr2379360f8f.33.1731884301218; Sun, 17 Nov 2024
 14:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com> <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com> <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
 <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com>
In-Reply-To: <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 14:58:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
Message-ID: <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 14:38, David Laight <David.Laight@aculab.com> wrote:
>
> I wonder if it reads better (and without extra comments) if the (long)
> cast is removed and the 'callers' are required to generate 'long' args.

I think that's much less obvious, actually. You'd have to explain why
it has those odd long constants now.

Also, technically it's not even really about "long", but "intptr_t",
which doesn't have a simple constant representation.

We're using "long" in this context because we don't want to have even
more dependencies in compiler.h - but I do think that means that the
cast is at least conceptually the proper way to do things: it's how
you'd do it in some user-mode header if you do this (as opposed to our
kernel model where we generate all these things from scratch anyway).

The "0*!(x)" is admittedly kind of ugly, and might be prettier as
"0&&(x)". Same number of characters, but technically one op less and
not mixing booleans and integer ops.

But honestly, nobody is ever going to look at the internals anyway
once it's all in there and works.

              Linus
