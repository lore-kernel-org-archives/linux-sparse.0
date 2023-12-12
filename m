Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvcgr5vR"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6591D9
	for <linux-sparse@vger.kernel.org>; Tue, 12 Dec 2023 01:39:47 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54cd8f5bb5cso7181503a12.1
        for <linux-sparse@vger.kernel.org>; Tue, 12 Dec 2023 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702373986; x=1702978786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWNhE8CgNDQO3nqLZCSIyjk9mukx9UZdrC/T7Saebw4=;
        b=lvcgr5vRTcGnQrBbKCEXeU+PQqMSpnc4aT892bG1nDVeZ0752UI7JSULz5kztcdTRV
         uD1tC4VDkJypWMe+p/i1KxG/v2cnun/uSauh7Z7UwOFnfcL2ZTdkuR6wZVXKKj8Y6M7I
         YWWWxVKGLUw1zGSAVukSrgcXnGeu8v6dhKyH1xjolvQYV9WlZt5WWhrJmmR3tUef+P3F
         bEd6gzINbKTo5a7wownnoNgipJWbnJHTqJ1PXxv2lrr6Ps2TULvgZYb17xtyAjDX33nx
         jyp0NUN6gkvycVV6aNFbHbX6vD8wYUC+Hf+IwHI1dslyWuqD2Foz7WgyQTVOIAhiki11
         Utcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373986; x=1702978786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWNhE8CgNDQO3nqLZCSIyjk9mukx9UZdrC/T7Saebw4=;
        b=sylu3hhyF73n6VS0WDJACY7CDDu9S3YlV7lo+OpzfWspWhnFwjH/cNqOyspVlHTuR2
         dJ+rV7jmrnTMtQBl+ebcEWXkZfSCqBo98nRjcJt/tkP8GyViG5tkBtVXwG/CiCvGwiNE
         74zQe+3RWKG/H6gr/tCOtBe4+oVoOnopC4rwbuihfAmEGhyuRrLoKwCaEiG/acuQ8gBz
         9B0F8lGJvVDB9mgks4YnxSc8vPx+lV20mLrAZKN4PAl3xdLP3nnufUf0efV9TPHV7sIx
         x+1ruYiHaYtQQqDhCuLSkbV/6+VDYJqmSqbaBPdaMdpz/oQwwZdWDKYQkZ+KTyi5E+VA
         BUIw==
X-Gm-Message-State: AOJu0YzLi+RXkUP4yf8+nDsoWsVQDUhQQaygxqjGkHESj5JrSgzlLtYW
	zAB17YXNMPUUUqctTyyreqUz0g==
X-Google-Smtp-Source: AGHT+IGGy2EJVwEbytqt3E+PtQzWtdaPqEKzQ9LJ09BFD9q8jq2f1L0GHuiuRkdZaE3XQg6jHeYFhw==
X-Received: by 2002:a50:cb84:0:b0:54f:47be:649 with SMTP id k4-20020a50cb84000000b0054f47be0649mr2797881edi.22.1702373986161;
        Tue, 12 Dec 2023 01:39:46 -0800 (PST)
Received: from localhost (h1f2c.n1.ips.mtn.co.ug. [41.210.159.44])
        by smtp.gmail.com with ESMTPSA id if3-20020a0564025d8300b0054afcab0af2sm4525414edb.59.2023.12.12.01.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:39:45 -0800 (PST)
Date: Tue, 12 Dec 2023 12:39:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <44e22df1-734e-49c5-b20b-4f4cdbce24a6@suswa.mountain>
References: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
 <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>

On Mon, Dec 11, 2023 at 02:16:49PM +0100, Luc Van Oostenryck wrote:
> On Fri, Dec 08, 2023 at 12:49:34PM +0300, Dan Carpenter wrote:
> > The kernel has recently started using the __cleanup__ attribute.  Save
> > a pointer to cleanup function.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2:  The first version of this patch had a bug handling a list of
> >      declarations.  I had to add a .cleanup = NULL at the start of
> >      the loops iterations in declaration_list() and
> >      external_declaration().
> 
> OK. See some notes here under, but first at all please forgive my very long delay.
>  

I would demand my money back, but I checked with my accountant and it
turns out I'm not paying you anything.  :P

> > diff --git a/parse.c b/parse.c
> > index 3d6fef7cb011..e5b5e6acc062 100644
> > --- a/parse.c
> > +++ b/parse.c
> > @@ -537,6 +542,7 @@ static struct init_keyword {
> >  	/* Attributes */
> >  	D("packed",		&packed_op),
> >  	D("aligned",		&aligned_op),
> > +	D("__cleanup__",	&cleanup_op),

> 
> This should simply be D("cleanup" (to accept both the plain form and the __X__ form).
> 
> > @@ -1964,6 +1984,7 @@ struct token *typename(struct token *token, struct symbol **p, int *forced)
> >  	token = declarator(token, &ctx);
> >  	apply_modifiers(token->pos, &ctx);
> >  	sym->ctype = ctx.ctype;
> > +	sym->cleanup = ctx.cleanup;
> 
> I don't think this should be needed because the cleanup attribute should be
> 'attached' to individual symbols, not their types (but I have no idea what GCC do).
> 
> > @@ -2924,6 +2945,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
> >  
> >  	decl->ctype = ctx.ctype;
> >  	decl->ctype.modifiers |= mod;
> > +	decl->cleanup = ctx.cleanup;
> 
> Similarly, the attribute should only be applied to automatic variables,
> so this should not be needed/should be detected as an error.
> 

Yeah.  There are a couple other "cleanup" lines later in the function
that should be deleted as well, I see.

Let me test this out resend in a few days.

regards,
dan carpenter

