Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scXKq+31"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1683
	for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2023 02:14:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso8792420a12.2
        for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2023 02:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702462473; x=1703067273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLuxQ6qtfEqHkDRUqc0fEC50DgoNlLc/bmYj0VDpNUI=;
        b=scXKq+311m5Kwri0R73f4HU2jsH2KZPYpjjJ+TDsSpwrKMAu95dF1Vc0k/tW1ZNU+7
         pm7+2WLwLiym3TQjl1PhoFoJzaU9ZQdaxfaVZladvMdKmH0IwxFdLPQ0V+vKBF59TbaM
         6pEpfoz4tbeFZBsO4kh0FFNnwIzy+FHVvTKmT67OufL9CIHgRqUN4E0WhVclnhgiY/0r
         +RKE7UHNz6uFylrkqgUNkRsd42Jwcv6v8JPLZiA/ba5sAtQxSlNwj+rNid4xR4iep9Q4
         27wAA4GwU8nTKXQGoQnEDGg3EpgLY/6gLF1wgGll8G6pAF4pyPuR0fzBp8ipw+zmH9Gf
         mw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462473; x=1703067273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLuxQ6qtfEqHkDRUqc0fEC50DgoNlLc/bmYj0VDpNUI=;
        b=DL0D2dqxypeu1oi7OSgBt686YYSFY6d0t4lRHgruVHSn/eGC6wiKXGwecJIkc3QT6D
         jn1Ue9XuoXX/7pBV5/oE2iiIC/1or/VU+WaFzH5AINgSwlenxXPltEuVmqjiMz/VKeEw
         bDYIVHwVW/maeOHmT5femqMUOjiKE2J3kzOHtNFSgJIvNTf1o83mLmCCW3pHF5PtkAlS
         HUxvHZgdzhMwj/7O0x5el7II2CW5o5fEYUdKiUhAv70aorgsT+MTDiyUqXhcdvAVHb5O
         Ljp86Ds1Kqh8rcDxLHNEnYL/WTcefHSf8wp71BdIYXgHKtfcEJNAvFWbsJccGaPEz4Ka
         5oTw==
X-Gm-Message-State: AOJu0Ywu98w9sDDv/AUwZMyOdBtK/zpqYx6zXpZCZofTyCX7a1vG8Efv
	bhbiSbvek2OVPM3vAcwgeCDnCA==
X-Google-Smtp-Source: AGHT+IFY3fUUqXkfd9G6ugGqbx6v3Be7vj6+W73eM3ipOLlAK79IkpvcZiu979NcCH6lA+mI9FIlgQ==
X-Received: by 2002:a50:9ea2:0:b0:550:e341:79b2 with SMTP id a31-20020a509ea2000000b00550e34179b2mr4056112edf.16.1702462473502;
        Wed, 13 Dec 2023 02:14:33 -0800 (PST)
Received: from localhost (h1f2c.n1.ips.mtn.co.ug. [41.210.159.44])
        by smtp.gmail.com with ESMTPSA id dd2-20020a056402312200b0055227522386sm319918edb.77.2023.12.13.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:14:33 -0800 (PST)
Date: Wed, 13 Dec 2023 13:14:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <75ee8bd3-aa80-46dc-9f0c-874a8f4e9d48@suswa.mountain>
References: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
 <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>
 <44e22df1-734e-49c5-b20b-4f4cdbce24a6@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e22df1-734e-49c5-b20b-4f4cdbce24a6@suswa.mountain>

On Tue, Dec 12, 2023 at 12:39:40PM +0300, Dan Carpenter wrote:
> > > @@ -2924,6 +2945,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
> > >  
> > >  	decl->ctype = ctx.ctype;
> > >  	decl->ctype.modifiers |= mod;
> > > +	decl->cleanup = ctx.cleanup;
> > 
> > Similarly, the attribute should only be applied to automatic variables,
> > so this should not be needed/should be detected as an error.
> > 
> 
> Yeah.  There are a couple other "cleanup" lines later in the function
> that should be deleted as well, I see.

Hm...  Something went wrong.  When I remove this assignment then the
cleanup function isn't saved here:

void sched_exec(void)
{
	struct task_struct *p = get_current();
	struct migration_arg arg;
	int dest_cpu;

	for (class_raw_spinlock_irqsave_t scope __attribute__((__cleanup__(class_raw_spinlock_irqsave_destructor))) = class_raw_spinlock_irqsave_constructor(&p->pi_lock), *done = ((void *)0);
	     class_raw_spinlock_irqsave_lock_ptr(&scope) && !done;
	     done = (void *)1) {
		dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), 0x02);
		if (dest_cpu == debug_smp_processor_id())
			return;

		if (__builtin_expect(!!(!cpu_active(dest_cpu)), 0))
 			return;

		arg = (struct migration_arg){ p, dest_cpu };
	}
	stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
}

regards,
dan carpenter
