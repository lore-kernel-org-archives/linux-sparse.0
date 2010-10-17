From: Tomas Klacko <tomas.klacko@gmail.com>
Subject: Re: including sparse headers in C++ code
Date: Sun, 17 Oct 2010 12:31:26 +0200
Message-ID: <AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<20101009205930.GA4684@feather>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	<20101011224656.GN19804@ZenIV.linux.org.uk>
	<AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	<AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
	<AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
	<AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
	<20101016191153.GA19324@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37108 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291Ab0JQKbj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Oct 2010 06:31:39 -0400
Received: by iwn35 with SMTP id 35so2809181iwn.19
        for <linux-sparse@vger.kernel.org>; Sun, 17 Oct 2010 03:31:39 -0700 (PDT)
In-Reply-To: <20101016191153.GA19324@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

On Sat, Oct 16, 2010 at 9:11 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> On Sat, Oct 16, 2010 at 06:03:53PM +0200, Tomas Klacko wrote:
>> On Wed, Oct 13, 2010 at 2:37 AM, Christopher Li <sparse@chrisli.org>=
 wrote:
>> > On Tue, Oct 12, 2010 at 3:45 PM, Tomas Klacko <tomas.klacko@gmail.=
com> wrote:

>> >> =A0/* Silly type-safety check ;) */
>> >> =A0#define DECLARE_PTR_LIST(listname,type) =A0 =A0 =A0 =A0struct =
listname { type *list[1]; }
>> >> -#define CHECK_TYPE(head,ptr) =A0 =A0 =A0 =A0 =A0 (void)(&(ptr) =3D=
=3D &(head)->list[0])
>> >> =A0#define TYPEOF(head) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __typ=
eof__(&(head)->list[0])
>> >> =A0#define VRFY_PTR_LIST(head) =A0 =A0 =A0 =A0 =A0 =A0(void)(size=
of((head)->list[0]))
>> >>
>> >> +#ifndef __cplusplus
>> >> +#define CHECK_TYPE(head,ptr) =A0 =A0 =A0 =A0 =A0 (void)(&(ptr) =3D=
=3D &(head)->list[0])
>> >> +#else
>> >> +/* I don't know yet how to do this better in C++. */
>> >> +#define CHECK_TYPE(head,ptr) (void)((void*)&(ptr) =3D=3D (void*)=
&(head)->list[0])
>> >> +#endif
>> >
>> > If you can't get CHECK_TYPE work in C++, you might just make it an=
 empty define
>> > instead of doing useless point dancing. At least it is clear that =
it does not
>> > do any thing here.
>>
>> True. How about
>> #define CHECK_TYPE (head,ptr) =A0 (void)(1)
>> ?
>
> As far as I can tell, CHECK_TYPE works just fine in C++. =A0I could e=
asily
> compile an invocation of CHECK_TYPE, as well as some simple examples
> that called the macros which invoked CHECK_TYPE. =A0When I tried
> FOR_EACH_PTR, I encountered *other* warnings (related to assigning (v=
oid
> *) to some other type without a cast), but those warnings didn't come
> from CHECK_TYPE.

Maybe I did not investigate deeply enough to find out the origin of
the warnings.
But I get no warnings/errors, when I disable CHECK_TYPE in C++ code.

> What warning do you encounter about CHECK_TYPE?

In the following code1 (file main.cc):
int main(int argc, char* argv[])
{
    struct string_list *files=3DNULL;

    void* file_void;
    char* file_char;

    struct symbol_list *symbols=3DNULL;
    struct symbol_list *all_symbols=3DNULL;

    symbols=3Dsparse_initialize(argc, argv, &files);
    concat_symbol_list(symbols, &all_symbols);

    FOR_EACH_PTR_NOTAG(files, file_void) {  // line 19
        file_char=3D(char*)file_void;
        symbols=3Dsparse(file_char);
        concat_symbol_list(symbols, &all_symbols);
    } END_FOR_EACH_PTR_NOTAG(file_void);

    exit(EXIT_SUCCESS);
}

I get:
main.cc: In function =91int main(int, char**)=92:
main.cc:19: error: comparison between distinct pointer types =91void*=92
and =91char*=92 lacks a cast

compiler and (important) flags:
g++ (GCC) 4.2.4 (Ubuntu 4.2.4-1ubuntu4), -Wall -Werror


Now, the code2 (file main.cc):
int main(int argc, char* argv[])
{
    struct string_list *files=3DNULL;

    char* file_char;

    struct symbol_list *symbols=3DNULL;
    struct symbol_list *all_symbols=3DNULL;

    symbols=3Dsparse_initialize(argc, argv, &files);
    concat_symbol_list(symbols, &all_symbols);

    FOR_EACH_PTR_NOTAG(files, file_char) {  // line 18
        symbols=3Dsparse(file_char);
        concat_symbol_list(symbols, &all_symbols);
    } END_FOR_EACH_PTR_NOTAG(file_char);

    exit(EXIT_SUCCESS);
}

I get error:
main.cc: In function =91int main(int, char**)=92:
main.cc:18: error: invalid conversion from =91void*=92 to =91char*=92


sparse headers included (in both code examples):

#ifdef __cplusplus
extern "C" {
#endif

#include <sparse/allocate.h>
#include <sparse/expression.h>
#include <sparse/lib.h>
#include <sparse/linearize.h>
#include <sparse/token.h>
#include <sparse/parse.h>
#include <sparse/symbol.h>

#ifdef __cplusplus
}
#endif

Tomas Klacko
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
