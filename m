From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH-v2 2/4] Replace SYM_ and MOD_ #defines with enums in
	symbol.h.
Date: Tue, 2 Jun 2009 23:43:05 -0400
Message-ID: <db65a1cd0906022043l6a9f175asd79c85e82287e15@mail.gmail.com>
References: <1243881445-30069-1-git-send-email-naesten@gmail.com>
	 <1243881445-30069-2-git-send-email-naesten@gmail.com>
	 <70318cbf0906021344w2adcf585g7d7adcd320d66fa9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:15715 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbZFCDnE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 2 Jun 2009 23:43:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so17758272and.1
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jun 2009 20:43:05 -0700 (PDT)
In-Reply-To: <70318cbf0906021344w2adcf585g7d7adcd320d66fa9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Jun 2, 2009 at 4:44 PM, Christopher Li <sparse@chrisli.org> wro=
te:
> On Mon, Jun 1, 2009 at 11:37 AM, Samuel Bronson <naesten@gmail.com> w=
rote:
>> Adjust the associated fields to match. While we're here, change
>> some nearby bitfields from "char" to "int" so GDB doesn't bother
>> showing character literals for them.
>
>> +enum modifier {
>> + =C2=A0 =C2=A0 =C2=A0 MOD_AUTO =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1 << =
0,
>
> The patch does not apply to my tree. The modifier is definitely not
> an enum because we apply bit operation to it.

Hmm, which tree is yours? I pulled from
git://git.kernel.org/pub/scm/devel/sparse/sparse.git

As for the bit operations, those are perfectly legal for enum values,
and there are two similar enum types defined in this very header:

enum namespace {
        NS_NONE         =3D 0,
        NS_MACRO        =3D 1,
        NS_TYPEDEF      =3D 2,
        NS_STRUCT       =3D 4,  // Also used for unions and enums.
        NS_LABEL        =3D 8,
        NS_SYMBOL       =3D 16,
        NS_ITERATOR     =3D 32,
        NS_PREPROCESSOR =3D 64,
        NS_UNDEF        =3D 128,
        NS_KEYWORD      =3D 256,
};

enum keyword {
        KW_SPECIFIER    =3D 1 << 0,
        KW_MODIFIER     =3D 1 << 1,
        KW_QUALIFIER    =3D 1 << 2,
        KW_ATTRIBUTE    =3D 1 << 3,
        KW_TYPEOF       =3D 1 << 4,
        KW_STATEMENT    =3D 1 << 5,
        KW_ASM          =3D 1 << 6,
        KW_MODE         =3D 1 << 7,
};

> Changing bitfield from "char" to "int" has risk of making the symbol
> struct bigger. We don't want that because symbol is a very common
> structure for sparse.

When could this actually happen? Here (on i386), pahole says this:

struct symbol {
        enum type                  type:8;               /*     0:24  4=
 */
        enum namespace             namespace:9;          /*     0:15  4=
 */
        unsigned int               used:1;               /*     0:14  4=
 */
        enum sym_attr              attr:2;               /*     0:12  4=
 */
        unsigned int               enum_member:1;        /*     0:11  4=
 */
        unsigned int               bound:1;              /*     0:10  4=
 */

        /* XXX 10 bits hole, try to pack */

        struct position            pos;                  /*     4     8=
 */

[...]

        union {
                struct basic_block * bb_target;          /*           4=
 */
                void *             aux;                  /*           4=
 */
                struct {
                        char       kind;                 /*   116     1=
 */

                        /* Bitfield combined with previous fields */

                        unsigned int visited:1;          /*   116:23  4=
 */
                };                                       /*           4=
 */
        };                                               /*   116     4=
 */

If you run c2xml on the pahole output, you'll get:

  <symbol type=3D"struct" id=3D"_9" ident=3D"position" file=3D"-"
start-line=3D"10" start-col=3D"8" end-line=3D"21" end-col=3D"2" bit-si
ze=3D"64" alignment=3D"4" offset=3D"0">

in the output, indicating that the 10-bit hole near the beginning is
not due to the use of "unsigned int" instead of "unsigned char" for
the bitfields before the hole, but due to the alignment required for
the "struct position" following the hole.

The "visited" bitfield doesn't cause a problem either, because it is
packed into the same word as the "kind" field, and the other members
of that union both take a word anyway.

Looking it up in K&R 2nd edition, I see that the treatment of
bitfields is almost entirely implementation-defined, so I
unfortunately can't really make any general statements about this --
does anyone (perhaps someone on another architecture) have something
to add?
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
