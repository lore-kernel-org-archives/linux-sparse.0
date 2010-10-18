From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: including sparse headers in C++ code
Date: Sun, 17 Oct 2010 22:39:56 -0700
Message-ID: <20101018053955.GA1628@feather>
References: <20101009205930.GA4684@feather>
 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
 <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
 <20101011224656.GN19804@ZenIV.linux.org.uk>
 <AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
 <AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
 <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
 <AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
 <20101016191153.GA19324@feather>
 <AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40600 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab0JRFkK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Oct 2010 01:40:10 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

On Sun, Oct 17, 2010 at 12:31:26PM +0200, Tomas Klacko wrote:
> On Sat, Oct 16, 2010 at 9:11 PM, Josh Triplett <josh@joshtriplett.org=
> wrote:
> > On Sat, Oct 16, 2010 at 06:03:53PM +0200, Tomas Klacko wrote:
> >> On Wed, Oct 13, 2010 at 2:37 AM, Christopher Li <sparse@chrisli.or=
g> wrote:
> >> > On Tue, Oct 12, 2010 at 3:45 PM, Tomas Klacko <tomas.klacko@gmai=
l.com> wrote:
>=20
> >> >> =C2=A0/* Silly type-safety check ;) */
> >> >> =C2=A0#define DECLARE_PTR_LIST(listname,type) =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct listname { type *list[1]; }
> >> >> -#define CHECK_TYPE(head,ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (void)(&(ptr) =3D=3D &(head)->list[0])
> >> >> =C2=A0#define TYPEOF(head) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __typeof__(&(head)->list[0])
> >> >> =C2=A0#define VRFY_PTR_LIST(head) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(void)(sizeof((head)->list[0]))
> >> >>
> >> >> +#ifndef __cplusplus
> >> >> +#define CHECK_TYPE(head,ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (void)(&(ptr) =3D=3D &(head)->list[0])
> >> >> +#else
> >> >> +/* I don't know yet how to do this better in C++. */
> >> >> +#define CHECK_TYPE(head,ptr) (void)((void*)&(ptr) =3D=3D (void=
*)&(head)->list[0])
> >> >> +#endif
> >> >
> >> > If you can't get CHECK_TYPE work in C++, you might just make it =
an empty define
> >> > instead of doing useless point dancing. At least it is clear tha=
t it does not
> >> > do any thing here.
> >>
> >> True. How about
> >> #define CHECK_TYPE (head,ptr) =C2=A0 (void)(1)
> >> ?
> >
> > As far as I can tell, CHECK_TYPE works just fine in C++. =C2=A0I co=
uld easily
> > compile an invocation of CHECK_TYPE, as well as some simple example=
s
> > that called the macros which invoked CHECK_TYPE. =C2=A0When I tried
> > FOR_EACH_PTR, I encountered *other* warnings (related to assigning =
(void
> > *) to some other type without a cast), but those warnings didn't co=
me
> > from CHECK_TYPE.
>=20
> Maybe I did not investigate deeply enough to find out the origin of
> the warnings.
> But I get no warnings/errors, when I disable CHECK_TYPE in C++ code.
>=20
> > What warning do you encounter about CHECK_TYPE?
>=20
> In the following code1 (file main.cc):
> int main(int argc, char* argv[])
> {
>     struct string_list *files=3DNULL;
>=20
>     void* file_void;
>     char* file_char;
>=20
>     struct symbol_list *symbols=3DNULL;
>     struct symbol_list *all_symbols=3DNULL;
>=20
>     symbols=3Dsparse_initialize(argc, argv, &files);
>     concat_symbol_list(symbols, &all_symbols);
>=20
>     FOR_EACH_PTR_NOTAG(files, file_void) {  // line 19
>         file_char=3D(char*)file_void;
>         symbols=3Dsparse(file_char);
>         concat_symbol_list(symbols, &all_symbols);
>     } END_FOR_EACH_PTR_NOTAG(file_void);
>=20
>     exit(EXIT_SUCCESS);
> }
>=20
> I get:
> main.cc: In function =E2=80=98int main(int, char**)=E2=80=99:
> main.cc:19: error: comparison between distinct pointer types =E2=80=98=
void*=E2=80=99
> and =E2=80=98char*=E2=80=99 lacks a cast

This warning means that CHECK_TYPE has done its job correctly; you
should not use the void * file_void to iterate over a list of files.=C2=
=A0
=46OR_EACH_PTR (and the _NOTAG variant) expect a list type and the
corresponding element type, and they use CHECK_TYPE to make this
type-safe.

> compiler and (important) flags:
> g++ (GCC) 4.2.4 (Ubuntu 4.2.4-1ubuntu4), -Wall -Werror
>=20
>=20
> Now, the code2 (file main.cc):
> int main(int argc, char* argv[])
> {
>     struct string_list *files=3DNULL;
>=20
>     char* file_char;
>=20
>     struct symbol_list *symbols=3DNULL;
>     struct symbol_list *all_symbols=3DNULL;
>=20
>     symbols=3Dsparse_initialize(argc, argv, &files);
>     concat_symbol_list(symbols, &all_symbols);
>=20
>     FOR_EACH_PTR_NOTAG(files, file_char) {  // line 18
>         symbols=3Dsparse(file_char);
>         concat_symbol_list(symbols, &all_symbols);
>     } END_FOR_EACH_PTR_NOTAG(file_char);
>=20
>     exit(EXIT_SUCCESS);
> }
>=20
> I get error:
> main.cc: In function =E2=80=98int main(int, char**)=E2=80=99:
> main.cc:18: error: invalid conversion from =E2=80=98void*=E2=80=99 to=
 =E2=80=98char*=E2=80=99

This warning doesn't come from CHECK_TYPE; it comes from the subsequent
implicit conversion from the list's void * to the desired type char *,
which will indeed need a cast to work correctly when included from C++.

Based on these two code examples, I think you don't need to change
CHECK_TYPE at all.  (And the user should always use code like your
second example, not your first example.)

(Of course, if someone really wants to use these lists from C++, they
might want to build appropriate type-safe C++ iterator types on top of
the ptrlist bits. :) )

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
