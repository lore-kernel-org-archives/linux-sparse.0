Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjwt4wAu"
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66462106
	for <linux-sparse@vger.kernel.org>; Mon,  4 Dec 2023 07:02:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so5846716a12.3
        for <linux-sparse@vger.kernel.org>; Mon, 04 Dec 2023 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701702164; x=1702306964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3KzQIx9Ohkvm02uw6GTEKfHglHoMLN9A9s+VAnkulc=;
        b=hjwt4wAuwC+T07jf4LRMEh8cG2QkrjErMREokvbZWKAn34cPooBWlDIyr+WIJIVTxf
         hbz5a/Cnl1HCBzox/O+pfbiduTHpOn+dsyeiT18QbWRupr3y8whvri3Y3MfHac98sKbY
         4ntCIDgLTv6gmJrYfClnxiOBmIkN17oZFs5DqlztumaxmUR6P9CQzE36oqxN0AgOd3xS
         5KuyIFGYn5d654uZqfIZwYfmZoMNXoES5o9qnSRAQ3iZUzuJRS5oKsz/cinKmsGfRuA8
         1ohJ9gcwqTP80FFpj2IIykkqfvF6cGvix4xJ+f0bFYOhFLtfgSUiDWXwa7IqLl/wjbZo
         kcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701702164; x=1702306964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3KzQIx9Ohkvm02uw6GTEKfHglHoMLN9A9s+VAnkulc=;
        b=VLiD2S94NdH3i5h03d9d4JjY+f7lnfimjTE9BLLFxNe05MDnoAUwQ0vioT/JK1m/AY
         i8dRpazleSfLeYK3f8xyuYMTBLfzB3YP0o09I5s/svqjoEny1nNUAJcfREdVTO6l2TXq
         UuSVsBD9PZWGv9yDE4pr0FPjraFhZmnITDxTtAUNlUstKkVDD99uU2vRc1isV6fmlxCE
         BOrY2T9BrcvGFB6/j/Ac5N1iXxOYDldIcpeivVhl11OKktmcT1IlasgZBdm+gDV74OUN
         JgdDZLCL1m7xCOo2FyNq6XmkfVN6j93CTSr0Y5isM5OHQdd8s1dZ/V7PMR9Ggt5GL6Sl
         Cgtw==
X-Gm-Message-State: AOJu0YyaAJCnpjekj4XWnNVuXlVdtY0V3Ofg257gxeJhj8u/+QFk2WnG
	t6XxE4xUb2C6iMXMchhVUjloeEjUVMQBd3rgOUs=
X-Google-Smtp-Source: AGHT+IGIqVLWZM/nhnUdOXE4Niz/99pkPjfKGKEfE2TjzQCWrXxZyYbGnfxqgOshqM0hqdtv21ymfttkPR7gg5AnsWI=
X-Received: by 2002:a50:c312:0:b0:54c:ff23:7cb6 with SMTP id
 a18-20020a50c312000000b0054cff237cb6mr82994edb.41.1701702163719; Mon, 04 Dec
 2023 07:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310080853.UhMe5iWa-lkp@intel.com> <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
 <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com>
 <v3beizdy56kqr4jv4zhmy6slriifuqcqll2eucqykqjilxfdya@s5v5jaflavwh>
 <CAFULd4YMcHhkSR4P5tq3ghLQyUCkiTOKS6PQd1Bec-2NicUiwQ@mail.gmail.com>
 <oz64jus6uqtwj76jvc5imywhwnrur4s6vuvcg3lntpj4s7dqna@fd4pecivhf2u> <CAFULd4YJ2vC-3Yj648XRquz0rh5jUgJEw6S89JC-h8p5A4-WTg@mail.gmail.com>
In-Reply-To: <CAFULd4YJ2vC-3Yj648XRquz0rh5jUgJEw6S89JC-h8p5A4-WTg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 4 Dec 2023 16:02:32 +0100
Message-ID: <CAFULd4buj4yX9Rgef1H3F4Sk042CaP1v=DwZBi=LHg1oEvQ2Sw@mail.gmail.com>
Subject: Re: sparse: Expected ) at end of cast operator, got __seg_gs
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:50=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Mon, Dec 4, 2023 at 3:37=E2=80=AFPM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > On Mon, Dec 04, 2023 at 02:57:53PM +0100, Uros Bizjak wrote:
> > > On Mon, Dec 4, 2023 at 2:05=E2=80=AFPM Luc Van Oostenryck <luc.vanoos=
tenryck@gmail.com> wrote:
> > >
> > > __seg_gs qualified variables can be referenced anywhere in the code, =
e.g.:
> > >
> > > --cut here--
> > > __seg_gs int m;
> > >
> > > int foo (void)
> > > {
> > >  return m + m;
> > > }
> >
> > Yes, of course. But my point was not if they *can* be dereferenced but =
rather
> > if *in the kernel, do want or not to use 'naked' __seg_gs qualified var=
iable*.
> > In other words, do we want to be warned if someone, somewhere try to
> > dereference such qualified variable without using the accessor function=
?
> > And I think the answer to this question should be 'yes'.
>
> Not really - when used as e.g.:
>
> extern const struct pcpu_hot __seg_gs const_pcpu_hot;
>
> we can use variable directly, e.g.:
>
> return const_pcpu_hot.current_task;
>
> This way, the compiler is able to significantly reduce the number of
> loads from current_task, which is not achievable when the accessor is
> used to dereference the structure. In the x86/percpu branch, the
> number of loads from current_task were reduced from ~4700 to 3201 by
> using 'naked' __seg_gs qualified variable. IOW, the benefit of using
> __seg_gs is to be able to access the naked variable.

Additionally, the compiler checks access to this internal ("named")
address space, and will prevent dereference from "generic" address
space without appropriate casts. So, compiling:

--cut here--
__seg_gs int *m;

int *foo (void)
{
  return m;
}
--cut here--

will generate "error: return from pointer to non-enclosed address space".

But the following is allowed:

int *foo (void)
{
  return (int *)(unsigned long) m;
}

Uros.
