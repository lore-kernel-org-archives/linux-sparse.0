From: "Dan Carpenter" <error27@gmail.com>
Subject: Re: Moving smatch to use sparse
Date: Thu, 5 Oct 2006 23:31:14 -0700
Message-ID: <a63d67fe0610052331y4e914869k7c0feaf42bb8b14c@mail.gmail.com>
References: <a63d67fe0607140925h3665cd98ibc2fab07f6f80360@mail.gmail.com>
	 <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com>
	 <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com>
	 <20061005092656.GA17866@uranus.ravnborg.org>
	 <a63d67fe0610050249j1cadc3bfk438b66ec8ad34586@mail.gmail.com>
	 <20061005102542.GD23093@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:2415 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932242AbWJFGbQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Oct 2006 02:31:16 -0400
Received: by ug-out-1314.google.com with SMTP id o38so285354ugd
        for <linux-sparse@vger.kernel.org>; Thu, 05 Oct 2006 23:31:14 -0700 (PDT)
In-Reply-To: <20061005102542.GD23093@wohnheim.fh-wedel.de>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, smatch-discuss@lists.sf.net, linux-sparse@vger.kernel.org

On 10/5/06, J=F6rn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
> One advantage over gcc or plain sparse is that code checking can be
> done in two passes.  Pass one collects all sorts of information for
> every compilation unit.  Pass two can then combine the information fo=
r
> all compilation units and do global checking of some sort.
>
> For example, the currently debated "may be used uninitialized" warnin=
g
> in gcc is simply not able to detect something like:
>
> foo.c:
>         int foo;
>         do_initialize(&foo);
>         do_something(foo);
> bar.c:
> void do_initialize(int *bar)
> {
>         *bar =3D 0;
> }
>
> The code is 100% correct, but gcc only looks at foo.c and spits out a
> warning.  Smatch can do better than that - if someone writes a
> checker.
>
> J=F6rn
>

Actually, I think gcc handles that specific example correctly...  If
do_initialize() is in the same file it looks to see if it actually
initializes it or not.  If it's in a seperate file then it assumes
that it initializes it and doesn't print a warning.

I'm using gcc 4.0.3.

regards,
dan carpenter
