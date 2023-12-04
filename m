Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFuSdTYZ"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D9CB
	for <linux-sparse@vger.kernel.org>; Mon,  4 Dec 2023 06:50:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c74b3cd4cso4576741a12.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Dec 2023 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701701432; x=1702306232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxw3NezN8WvqyKAECm2+qxGYf+RfnNt7jah6q217Xi4=;
        b=nFuSdTYZbkuR6atCMKXTcZ8s2u0tKxFOv4jHPVPe3N+7cS8yeH9zqlmIb0WZM9R9t/
         9fHieoX+O4hE3YlXZsmGZl37OmjTvs9wT0Tib5WiLv71rcI12LsLwDrEvvkHau/10kiG
         iM44odkXUQCDRQVZQCCzK2LS3l3v7+nBXc+U96y4Qag8ek7i5G/Y0IR+f2rxFFWAXpO3
         cVYP4k1Kd9o9Mq+lEr8dNQYNBjnRBt0mMigzlDJyG6JUKF7WampjCe5qj8wumBT3jBvv
         KG+h2MKFsgczAVZgGQRuzFdUdIZf++/AQ2toA11XMBZrXoFLP/LfXQpD9XNY5LLwvSbF
         Py5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701432; x=1702306232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxw3NezN8WvqyKAECm2+qxGYf+RfnNt7jah6q217Xi4=;
        b=FWBBJGpVvP6sMbPWOdcw++4VxC1aQPO1G6wUp9MRhwO9rUQTR0hDcpj3qbK57n5La5
         iSKFih6X/8w/HtZEg1MTNgQLHJF6FsN9y5ztxgARDjq39TRh5+wPRc8burVx5wSxvXCs
         ZuzyB0KMhIwwJRdQQwiq70vetWyHoT+pqMgcGCscnnq9GAt2C5p0xuPJ1h8Nl8NPdTxs
         SIJylRVO8XvQFhWp4JiqmtoQHQFKMm3LighUasd7KQ4a4y+VHHOua3oYNhVwS8GefKQN
         zlXxVCJtNA/GxpKy9JdqRchhcn/nCCqPCUrRrFvGcr6ZnOoiSQIwOT5A3r1nh/ZRgLGc
         kpxg==
X-Gm-Message-State: AOJu0Yzx57SEsSuV1EUt+i3mL9j0eanLdtTa8nwzcl+/E9npAco+nXdu
	L/cHk782epC98xZv+woJhqBwZbQ8q2tgOZDRZ8aHvvHqTa+LNA==
X-Google-Smtp-Source: AGHT+IHv/szn58wzpgjUhIrg4s10HtNrfoj36g129eY0qZP14hx/pIdTWZL90u2MyNyXbICPg7sLn9pomoQRbT0hU/c=
X-Received: by 2002:a50:999e:0:b0:54c:a78e:efc0 with SMTP id
 m30-20020a50999e000000b0054ca78eefc0mr2710511edb.30.1701701431734; Mon, 04
 Dec 2023 06:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310080853.UhMe5iWa-lkp@intel.com> <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
 <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com>
 <v3beizdy56kqr4jv4zhmy6slriifuqcqll2eucqykqjilxfdya@s5v5jaflavwh>
 <CAFULd4YMcHhkSR4P5tq3ghLQyUCkiTOKS6PQd1Bec-2NicUiwQ@mail.gmail.com> <oz64jus6uqtwj76jvc5imywhwnrur4s6vuvcg3lntpj4s7dqna@fd4pecivhf2u>
In-Reply-To: <oz64jus6uqtwj76jvc5imywhwnrur4s6vuvcg3lntpj4s7dqna@fd4pecivhf2u>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 4 Dec 2023 15:50:20 +0100
Message-ID: <CAFULd4YJ2vC-3Yj648XRquz0rh5jUgJEw6S89JC-h8p5A4-WTg@mail.gmail.com>
Subject: Re: sparse: Expected ) at end of cast operator, got __seg_gs
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:37=E2=80=AFPM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Mon, Dec 04, 2023 at 02:57:53PM +0100, Uros Bizjak wrote:
> > On Mon, Dec 4, 2023 at 2:05=E2=80=AFPM Luc Van Oostenryck <luc.vanooste=
nryck@gmail.com> wrote:
> >
> > __seg_gs qualified variables can be referenced anywhere in the code, e.=
g.:
> >
> > --cut here--
> > __seg_gs int m;
> >
> > int foo (void)
> > {
> >  return m + m;
> > }
>
> Yes, of course. But my point was not if they *can* be dereferenced but ra=
ther
> if *in the kernel, do want or not to use 'naked' __seg_gs qualified varia=
ble*.
> In other words, do we want to be warned if someone, somewhere try to
> dereference such qualified variable without using the accessor function?
> And I think the answer to this question should be 'yes'.

Not really - when used as e.g.:

extern const struct pcpu_hot __seg_gs const_pcpu_hot;

we can use variable directly, e.g.:

return const_pcpu_hot.current_task;

This way, the compiler is able to significantly reduce the number of
loads from current_task, which is not achievable when the accessor is
used to dereference the structure. In the x86/percpu branch, the
number of loads from current_task were reduced from ~4700 to 3201 by
using 'naked' __seg_gs qualified variable. IOW, the benefit of using
__seg_gs is to be able to access the naked variable.

Uros.
