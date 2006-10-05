From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: Moving smatch to use sparse
Date: Thu, 5 Oct 2006 12:25:42 +0200
Message-ID: <20061005102542.GD23093@wohnheim.fh-wedel.de>
References: <a63d67fe0607140925h3665cd98ibc2fab07f6f80360@mail.gmail.com> <a63d67fe0607151742l6a387783x59494b84de80be88@mail.gmail.com> <a63d67fe0610050141x251253fei59b93fff28505dc4@mail.gmail.com> <20061005092656.GA17866@uranus.ravnborg.org> <a63d67fe0610050249j1cadc3bfk438b66ec8ad34586@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:17594 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751615AbWJEKZ6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Oct 2006 06:25:58 -0400
Content-Disposition: inline
In-Reply-To: <a63d67fe0610050249j1cadc3bfk438b66ec8ad34586@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, smatch-discuss@lists.sf.net, linux-sparse@vger.kernel.org

On Thu, 5 October 2006 02:49:36 -0700, Dan Carpenter wrote:
> On 10/5/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> >For the mindless - can you please repeat what smatch does?
>=20
> It's a static code checker.  Take a look at check_null_deref.c.
>=20
> You've got a function called match_assign() that gets called for ever=
y
> assignment:
>=20
>       name =3D get_variable_from_expr(expr->left, &sym);
>       name =3D alloc_string(name);
>       if (is_null(expr->right))
>               set_state(name, my_id, sym, ISNULL);
>       else
>               set_state(name, my_id, sym, NONNULL);
>=20
> Say it encounter the code:  a =3D foo(), then it's going to set the
> state of 'a' to NONNULL;
>=20
> Then say it encounters a call to tty_ldisc_deref(), it's going to
> check the state of 'a' and if it's ISNULL or UNDEFINED it's going to
> print a message out.
>=20
> More often you have something like:
> a =3D NULL;
> if (b) {
>       a =3D foo();
> }
> a->x;  <---Error.  'a' is Undefined.
>=20
> The idea is that it's easy to write checks once all the state trackin=
g
> code is in place.
>=20
> Use it like this:
> make C=3D1 CHECK=3D/path/to/smatch > warns.out 2>&1

One advantage over gcc or plain sparse is that code checking can be
done in two passes.  Pass one collects all sorts of information for
every compilation unit.  Pass two can then combine the information for
all compilation units and do global checking of some sort.

=46or example, the currently debated "may be used uninitialized" warnin=
g
in gcc is simply not able to detect something like:

foo.c:
	int foo;
	do_initialize(&foo);
	do_something(foo);
bar.c:
void do_initialize(int *bar)
{
	*bar =3D 0;
}

The code is 100% correct, but gcc only looks at foo.c and spits out a
warning.  Smatch can do better than that - if someone writes a
checker.

J=F6rn

--=20
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
