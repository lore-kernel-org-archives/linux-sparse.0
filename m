From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Thu, 27 Feb 2014 13:49:06 -0800
Message-ID: <1393537746.24588.143.camel@joe-AO722>
References: <1393462087.24588.50.camel@joe-AO722>
	 <530E8C2E.7080307@zytor.com> <1393466619.24588.65.camel@joe-AO722>
	 <20140227022857.GC23659@thin> <1393469594.24588.71.camel@joe-AO722>
	 <20140227025845.GA25145@thin> <530EB103.5070406@zytor.com>
	 <1393472326.24588.82.camel@joe-AO722> <20140227040050.GA8449@nicira.com>
	 <530EBCED.9020705@zytor.com> <20140227042636.GA9592@nicira.com>
	 <530EBFC7.9030309@zytor.com>
	 <CANeU7Q=RNXR00bQcPzJYTOcZmRSn3U31ZcadPTHu6Y_Uk0UnYw@mail.gmail.com>
	 <faa9e231-d561-417b-8b8b-95192cb0e56a@email.android.com>
	 <1393533563.24588.127.camel@joe-AO722>
	 <CANeU7QnZika4XsdS_=UwPc5uZgv2-m5vMdmZLyCynKK2YNKLvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:35919 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750942AbaB0VtK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 27 Feb 2014 16:49:10 -0500
In-Reply-To: <CANeU7QnZika4XsdS_=UwPc5uZgv2-m5vMdmZLyCynKK2YNKLvQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ben Pfaff <blp@nicira.com>, Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2014-02-27 at 12:55 -0800, Christopher Li wrote:
> On Thu, Feb 27, 2014 at 12:39 PM, Joe Perches <joe@perches.com> wrote:

> > Maybe the evaluate.c "size = bits_in_char;" assignment
> >
> >         if (size == 1 && is_bool_type(type)) {
> > -               warning(expr->pos, "expression using sizeof bool");
> > +               if (Wsizeof_bool)
> > +                       warning(expr->pos, "expression using sizeof bool");
> >                 size = bits_in_char;
> >         }
> >
> > should be
> >
> >         size = sizeof(_Bool) * 8;
> 
> The reason to use bits_in_xxxx is to allow sparse application to over write
> the size of int etc. If you don't like the bits_in_char here. You can introduce
> bits_in_bool and set that to sizeof(Bool)*8 by default. That way you don't
> hard code it.

There already is a bits_in_bool and it's default 1.

$ git grep -E "\bbits_in_\w+\s*=[^=]"
lib.c:          bits_in_long = 64;
lib.c:          bits_in_pointer = 64;
target.c:int bits_in_bool = 1;
target.c:int bits_in_char = 8;
target.c:int bits_in_short = 16;
target.c:int bits_in_int = 32;
target.c:int bits_in_long = 32;
target.c:int bits_in_longlong = 64;
target.c:int bits_in_longlonglong = 128;
target.c:int bits_in_float = 32;
target.c:int bits_in_double = 64;
target.c:int bits_in_longdouble = 80;
target.c:int bits_in_pointer = 32;
target.c:int bits_in_enum = 32;

> > And also, in sparse.1, Josh Triplett is shown as
> > the maintainer.  Maybe that should be changed to
> > Christopher Li
> 
> Maybe a separate patch.

That's fine with me too.  If you're the maintainer,
I think you should do that patch.  I don't see a need
for me to send any more right now though.

cheers, Joe

