From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/2] parser: define __builtin_unreachable
Date: Tue, 13 Jul 2010 11:12:13 -0700
Message-ID: <20100713181212.GB20289@feather>
References: <AANLkTikFmeXz9og4t98jm6QcAdRa6rIeCAv3oeFnTgd8@mail.gmail.com>
 <1278751162-10053-2-git-send-email-jslaby@suse.cz>
 <20100710090705.GA14881@feather>
 <AANLkTimf821jhfhU-Rsj7xa2S4EzuP23weoUSZVWsD2u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimf821jhfhU-Rsj7xa2S4EzuP23weoUSZVWsD2u@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, Larry Finger <Larry.Finger@lwfinger.net>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, Jul 13, 2010 at 12:52:48AM -0700, Chris Li wrote:
> On Sat, Jul 10, 2010 at 2:07 AM, Josh Triplett <josh@joshtriplett.org=
> wrote:
> > __builtin_unreachable has special semantics beyond just a function.
> > This definition will suffice to allow compilation, but
> > __builtin_unreachable should have the same effect in sparse that it=
 does
> > in GCC: mark the point (and the remainder of the basic block) as
> > unreachable. =A0Something like the mechanism used for handling nore=
turn
> > would work here as well; declaring the function to have attribute
> > noreturn would probably have almost the right semantics.
> >
>=20
> The attribute noreturn will apply to the whole function. The function
> NEVER returns.
> __builtin_unreachable only apply to current basic block. e.g. some
> error handling path like panic. The function can still return a value=
 on the
> normal path. It has different meaning than attribute noreturn. So I d=
on't think
> automatically give the function noreturn attribute is the right thing=
 to do.

No, I didn't mean that using __builtin_unreachable should mark the
function calling it as noreturn.  I meant that as an approximation to
the right behavior, __builtin_unreachable *itself* could have attribute
noreturn.

- Josh Triplett
