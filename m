From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of CFLAGS
Date: Wed, 18 Oct 2017 15:14:34 -0700
Message-ID: <CANeU7QnRU7EgQTX1DiDHQj7JZBeKs2ZAeHKKSJNQxhKPXwoKjA@mail.gmail.com>
References: <20171018150727.26821-1-jlayton@kernel.org> <CANeU7QmPgxKqjZpvudX_MYwhwGWx6nnZrats3brDMVvUUvBTFg@mail.gmail.com>
 <1508358019.4628.35.camel@poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:54455 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdJRWOg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 18:14:36 -0400
Received: by mail-yw0-f193.google.com with SMTP id w5so1902778ywg.11
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 15:14:35 -0700 (PDT)
In-Reply-To: <1508358019.4628.35.camel@poochiereds.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 18, 2017 at 1:20 PM, Jeff Layton <jlayton@poochiereds.net> wrot=
e:
>
> Fedora, Red Hat, etc., define some macros that are considered "standard"
> build options during packaging. These get passed into "make" and make is
> expected to add to that list as necessary.

Does all open source package follow this convention or that is a result
of a lot of open source project using autotools

>
> Here's what the make command looks like when called by rpmbuild with the
> fedora package (built out of my homedir):
>
>     $ make DESTDIR=3D/home/jlayton/rpmbuild/BUILDROOT/sparse-0.5.1-1.fc26=
.x86_64 PREFIX=3D/usr BINDIR=3D/usr/bin LIBDIR=3D/usr/lib64 INCLUDEDIR=3D/u=
sr/include PKGCONFIGDIR=3D/usr/lib64/pkgconfig -j16 'CFLAGS=3D-O2 -g -pipe =
-Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions -fst=
ack-protector-strong --param=3Dssp-buffer-size=3D4 -grecord-gcc-switches -s=
pecs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=3Dgeneric' HAVE_=
LLVM=3Dno

So here by specifying CFLAGS, the original assign for CFLAGS:

CFLAGS =3D -O$(OPT) -finline-functions -fno-strict-aliasing -g

The above assignment will be ignored. Is that intentional?

Put it in a different way, Now " -finline-functions
-fno-strict-aliasing" are no longer
pass to gcc when compile sparse files any more.

>
> This is how things like FORTIFY_SOURCE end up being widespread in
> distros without having to touch every program.
>
>
>> It seems wrong to overwrite CFLAGS from command line. That are
>> other flags store in the CFLAGS will get overwritten.
>>
>
> I'm not sure I understand the objection here. Basically we just want to
> pass in a "base" set of CFLAGS and then let make add others as it sees
> fit.

So your intention is just adding arguments. No removing existing CFLAG
arguments. e.g. removing " -finline-functions -fno-strict-aliasing" from
your invocation is just accident.

>> We have add some variable in the ALL_CFLAGS list for overwrite
>> purpose  e.g. CFLAGS_CMD then have command line over write that?
>>
>
> FWIW, I inherited this specfile long ago and have only tweaked it since.
> It could probably be better, but I'd like to make it less of a special
> snowflake over the long haul. Hand rolled makefiles are generally a pain
> in this regard.

Well, sparse is not using autotools. So it is always be special if you cons=
ider
autotools the norm.

If your goal is just add some baseline compile options to gcc.
It seems better by provide some thing like CFLAGS_CMD as part of the
ALL_CFLAGS group. Then you can just add your options there. The variable
name of "CFLAGS_CMD" is subject to discussion. You can make suggestions.
Overwrite the CFLAGS variable from command line does have side effect
of dropping some options like " -finline-functions -fno-strict-aliasing".
It comes down to is your intend to drop those?

>
> I can certainly adapt the specfile this to pass in some other variable
> than CFLAGS if you like, but I don't really see how that would improve
> anything.

" -finline-functions -fno-strict-aliasing" has impact on the output code
it produce. Unless you are intentionally dropping them. Provide other varia=
ble
for you to overwrite can preserve those compile flags.

You do know that once you specify CFLAGS in the make command line,
by default all other assign to CFLAGS from the Makefile will be ignored.

Chris
