From: Christopher Li <sparse@chrisli.org>
Subject: Re: Warning from ring buffer code (Was: Re: linux-next: tip tree
	build warning)
Date: Mon, 14 Sep 2009 10:09:27 -0700
Message-ID: <70318cbf0909141009v46581785m4c70edf31fcb79fa@mail.gmail.com>
References: <20090804161640.70817ee6.sfr@canb.auug.org.au>
	 <1249403089.4634.139.camel@localhost.localdomain>
	 <20090912165300.9d257283.sfr@canb.auug.org.au>
	 <20090912073906.GA3972@elte.hu> <1252753957.12217.10.camel@ht.satnam>
	 <1252941416.2964.143.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932075AbZINRJb@vger.kernel.org>
In-Reply-To: <1252941416.2964.143.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <srostedt@redhat.com>
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Sep 14, 2009 at 8:16 AM, Steven Rostedt <srostedt@redhat.com> w=
rote:
> static void func(int size_me) {
> =A0 =A0 =A0 =A0char array[size_me];
>
> =A0 =A0 =A0 =A0memcpy(array, "hello", size);
> };
>
> and sparse failed on it as well. Note, you need to have something cal=
l
> func, or sparse will ignore it.

Gcc allows variable size. Sparse expects the size of an array is consta=
nt.
=46or the kernel using variable array size is consider bad. Because the=
 kernel
has very limited stack size. (8K if I remember correctly). Using dynami=
c array
is very easy to overflow the stack without realizing it.

It deserves a warning. I agree the warning message can use a better des=
cription
though.

Chris
