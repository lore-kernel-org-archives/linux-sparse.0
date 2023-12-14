Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JR9wzan7"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A0F118
	for <linux-sparse@vger.kernel.org>; Thu, 14 Dec 2023 05:20:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-33635d11d92so1635682f8f.1
        for <linux-sparse@vger.kernel.org>; Thu, 14 Dec 2023 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702560025; x=1703164825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfvHU0s2p7F95DXElKuqxjhVtyzqAtsImGO+ErxhRIQ=;
        b=JR9wzan7yh2M+Qim7ie7LZEwkJVDkEFAvV2+ubWuUD7nIgEMHSkqkTYGcPHN/5vDyX
         e2/vsJMw1TORThwLRrLKPi58x3ukz3zEgLzXtkW74kM8+YiM/AUMqvK4M+ehwoNq8GyX
         cQCOP8l+JDaW6FPqal+0fu/opLrSVvYy6c1PW/ae/V9zckTpQQpTmY+1vj/+4x+ioxgJ
         rSNnzvZ9+XF1tS6sEQ6wFH3QvF8uK0IR2U7cZyMKijgz1oNRqDVFHiGRMkLHWtKgG29x
         0k9z6yNZmI33EvxfwdHxQJ8UrzUa+RbVtd2RT0lbt23u1btq0wYtR4RkbdjuTP+VTGCr
         nYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560025; x=1703164825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfvHU0s2p7F95DXElKuqxjhVtyzqAtsImGO+ErxhRIQ=;
        b=V1ohGdf7xvgd/7GacnEmnskEd8X3rL1B4S9kkmfr7UUiN8gQQ3RrDEMB1XbnlxTx4j
         Y3RSSKrhP1Os9zFh5fDXScSNKMla68l3EyAF12j+XGumwImlU3htxlZE80Tk3JGgbBlL
         99yOb88fPssgG5wJweaTEWDyNrHN7qVuDkgtsVrkWP65+1tnZpVoggNMIpfkeYW38qG9
         /RWMaBlcoCB7DmiSZXCp8Pes1Nv+iFlNq9++hpszbKu0oLBb8KgXPg/ptaCVSA9ckQ06
         LyR36AI/Mg1/r/DV9oj8DVRZzuWCkJGVMr7PdfbDReV4GCDvoMKIT9kx/cE6AoadYgGg
         9PuQ==
X-Gm-Message-State: AOJu0YyIUQylKU7QjN/mkeUUbdHd6pIW7OnmoGsariG8amovaXZeTWbf
	piwXVYCYZMmb4C9vsz1PxjY5U23eoCdu0UNifZ0=
X-Google-Smtp-Source: AGHT+IE40TE+fIOb16DOrhEJuK8xbxqgVqWaf+6BbyZlcouATY55iPdAAjj6B0phFgUOOUz1UO/e3Q==
X-Received: by 2002:adf:f590:0:b0:333:3cac:106c with SMTP id f16-20020adff590000000b003333cac106cmr5890896wro.60.1702560025540;
        Thu, 14 Dec 2023 05:20:25 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id v4-20020adff684000000b003364c47d75esm31185wrp.107.2023.12.14.05.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:20:25 -0800 (PST)
Date: Thu, 14 Dec 2023 16:20:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <c3884893-44fe-4622-8e8e-576a0bdff19f@suswa.mountain>
References: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
 <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>
 <44e22df1-734e-49c5-b20b-4f4cdbce24a6@suswa.mountain>
 <75ee8bd3-aa80-46dc-9f0c-874a8f4e9d48@suswa.mountain>
 <k6ztyjq24ik24qtsu3aqpipodzgq37i2ko42ag7wzn4t2ryrzf@i4gbxu7kvslt>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k6ztyjq24ik24qtsu3aqpipodzgq37i2ko42ag7wzn4t2ryrzf@i4gbxu7kvslt>

On Thu, Dec 14, 2023 at 02:05:22PM +0100, Luc Van Oostenryck wrote:
> On Wed, Dec 13, 2023 at 01:14:29PM +0300, Dan Carpenter wrote:
> > On Tue, Dec 12, 2023 at 12:39:40PM +0300, Dan Carpenter wrote:
> > > > > @@ -2924,6 +2945,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
> > > > >  
> > > > >  	decl->ctype = ctx.ctype;
> > > > >  	decl->ctype.modifiers |= mod;
> > > > > +	decl->cleanup = ctx.cleanup;
> > > > 
> > > > Similarly, the attribute should only be applied to automatic variables,
> > > > so this should not be needed/should be detected as an error.
> > > > 
> > > 
> > > Yeah.  There are a couple other "cleanup" lines later in the function
> > > that should be deleted as well, I see.
> > 
> > Hm...  Something went wrong.  When I remove this assignment then the
> > cleanup function isn't saved here:
> 
> Mmmmhh yes, my bad.
> I thought that the parsing functions followed closely the names of the
> C grammar in the spec. They largely do but not in this case (they can't
> because some context is needed to distinguish between 'declaration' and
> 'function-definition').
> 
> Would the following patch be OK for you when applied on top of your v2?
> It contains:
> - the attribute can be removed from the list of ignored attributes
> - I prefer to add the "attribute_cleanup," on its own line
> - I added some checks and a few corresponding testcases
> - the s/D("__cleanup__"/D("cleanup"/
> - and the removal of 'sym->cleanup = ctx.cleanup;' from typename() which
>   I think is still unneeded.

Yep.  Perfect.  Thanks so much!

regards,
dan carpenter

