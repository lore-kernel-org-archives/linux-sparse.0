From: Christopher Li <sparse@chrisli.org>
Subject: Re: including sparse headers in C++ code
Date: Tue, 12 Oct 2010 17:37:35 -0700
Message-ID: <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<20101009205930.GA4684@feather>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	<20101011224656.GN19804@ZenIV.linux.org.uk>
	<AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	<AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47107 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab0JMAhg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Oct 2010 20:37:36 -0400
Received: by gwj17 with SMTP id 17so1650652gwj.19
        for <linux-sparse@vger.kernel.org>; Tue, 12 Oct 2010 17:37:35 -0700 (PDT)
In-Reply-To: <AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Tue, Oct 12, 2010 at 3:45 PM, Tomas Klacko <tomas.klacko@gmail.com> =
wrote:
> Hi,
>
> Thanks everyone for your comments, I have refined the patch
> and I am posting the next version (below).
>
> On Tue, Oct 12, 2010 at 1:01 AM, Christopher Li <sparse@chrisli.org> =
wrote:
>> On Mon, Oct 11, 2010 at 3:46 PM, Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>>> On Tue, Oct 12, 2010 at 12:33:32AM +0200, Tomas Klacko wrote:
>>>

>>
>> I am about to complain the same thing. Al beats me to it.
>>
>> Tomas, can you limit the change on the header file C++ friendly firs=
t?
>> I don't think the rest of the C code need to be compile in C++, so i=
t is fine
>> using C++ key words.
>
> I don't think I quite get your question. I have limited the amount of=
 changes
> to the C source files, but there are still some. Which result for ins=
tance
> from renaming "struct symbol->namespace" to "struct symbol->ns".

Rename header members to avoid keyword are fine.  You don't need to cha=
nge
any thing that is internal of a C code. e.g. from your previous patch:
<quote>
-static struct storage *get_reg(struct regclass *class)
+static struct storage *get_reg(struct regclass *Class)
</quote>

This function is  outside of header file.

> However, I can probably try doing:
> struct symbol
> {
> ...
> #ifndef __cplusplus
> =A0enum namespace namespace;
> #else
> =A0enum name_space ns;
> #endif

Even worse.

I don't like the #ifndef __cplusplus at all. Try to keep it minimal.
Just make it "enum name_space ns;" is clear better than maintain two
different names.

> and then try to work out any consequences solely in the header files.
> After all, using different names for the same types in C++ versus C
> should still result in correct code.

That is evil.

> =A0 =A0 =A0 =A0if (token->pos.type =3D=3D TOKEN_IDENT) {
> +#ifndef __cplusplus
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct symbol *sym =3D lookup_symbol(t=
oken->ident, NS_SYMBOL | NS_TYPEDEF);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sym && (sym->namespace & NS_TYPE=
DEF);
> +#else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct symbol *sym =3D lookup_symbol(to=
ken->ident, (enum
> name_space)(NS_SYMBOL | NS_TYPEDEF));
> +#endif

Hmm, NS_SYMBOL | NS_TYPEDEF looks better.
Maybe declare NS_SYMBOL_OR_TYPEDEF =3D NS_SYMBOL | NS_TYPEDEF as
one of the enum name_space so we don't need to force cast here.


> +#ifdef __cplusplus
> +extern "C" {
> +#endif

Can you move this into your C++ code before including the sparse header=
s?
I don't want it in the sparse headers. Sparse is compiled in C,
shouldn't need to know
C++ at all.

>-       .class =3D CChar,
>+       .cls =3D CChar,

"klass" instead of "cls" ?

>
> +#ifdef __cplusplus
> +}
> +#endif
> +

And this too.

> =A0{
> +#ifndef __cplusplus
> =A0 =A0 =A0 =A0return undo_ptr_list_last((struct ptr_list **)head);
> +#else
> + =A0 =A0 =A0 return (struct instruction *)undo_ptr_list_last((struct=
 ptr_list **)head);
> +#endif

Just keep the else branch and remove the #ifndef. It is harmless to do
a type cast
in C here. Same for the following inline functions.


> =A0static inline void concat_symbol_list(struct symbol_list *from,
> struct symbol_list **to)
> diff --git a/linearize.h b/linearize.h
> index 50b3601..a385968 100644
> --- a/linearize.h
> +++ b/linearize.h
> @@ -314,9 +314,9 @@ static inline void remove_bb_from_list(struct
> basic_block_list **list, struct ba
> =A0}
>
> =A0static inline void replace_bb_in_list(struct basic_block_list **li=
st,
> - =A0 =A0 =A0 struct basic_block *old, struct basic_block *new, int c=
ount)
> + =A0 =A0 =A0 struct basic_block *old, struct basic_block *new_list, =
int count)
> =A0{
> - =A0 =A0 =A0 replace_ptr_list_entry((struct ptr_list **)list, old, n=
ew, count);
> + =A0 =A0 =A0 replace_ptr_list_entry((struct ptr_list **)list, old, n=
ew_list, count);

new_list -> newlist

> diff --git a/parse.h b/parse.h
> index 6b21e23..f2193e7 100644
> --- a/parse.h
> +++ b/parse.h
> @@ -35,10 +35,12 @@ struct statement {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct /* declaration */ {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct symbol_list *de=
claration;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> +#ifndef __cplusplus
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct /* label_arg */ {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct symbol *label;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct statement *labe=
l_statement;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> +#endif

What is this #ifndef  for?


> =A0/* Silly type-safety check ;) */
> =A0#define DECLARE_PTR_LIST(listname,type) =A0 =A0 =A0 =A0struct list=
name { type *list[1]; }
> -#define CHECK_TYPE(head,ptr) =A0 =A0 =A0 =A0 =A0 (void)(&(ptr) =3D=3D=
 &(head)->list[0])
> =A0#define TYPEOF(head) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __typeof_=
_(&(head)->list[0])
> =A0#define VRFY_PTR_LIST(head) =A0 =A0 =A0 =A0 =A0 =A0(void)(sizeof((=
head)->list[0]))
>
> +#ifndef __cplusplus
> +#define CHECK_TYPE(head,ptr) =A0 =A0 =A0 =A0 =A0 (void)(&(ptr) =3D=3D=
 &(head)->list[0])
> +#else
> +/* I don't know yet how to do this better in C++. */
> +#define CHECK_TYPE(head,ptr) (void)((void*)&(ptr) =3D=3D (void*)&(he=
ad)->list[0])
> +#endif

If you can't get CHECK_TYPE work in C++, you might just make it an empt=
y define
instead of doing useless point dancing. At least it is clear that it do=
es not
do any thing here.

> +#ifdef __cplusplus
> +extern "C" {
> +#endif

Get rid of this too.

> =A0static inline void update_tag(void *p, unsigned long tag)
> =A0{
> +#ifndef __cplusplus
> =A0 =A0 =A0 =A0unsigned long *ptr =3D p;
> +#else
> + =A0 =A0 =A0 unsigned long *ptr =3D (unsigned long *)p;
> +#endif
> =A0 =A0 =A0 =A0*ptr =3D tag | (~3UL & *ptr);
> =A0}

Just keep the #else branch and get rid of the #ifndef


> +++ b/token.h
> @@ -175,7 +175,11 @@ struct token {
> =A0static inline struct token *containing_token(struct token **p)
> =A0{
> =A0 =A0 =A0 =A0void *addr =3D (char *)p - ((char *)&((struct token *)=
0)->next - (char *)0);
> +#ifndef __cplusplus
> =A0 =A0 =A0 =A0return addr;
> +#else
> + =A0 =A0 =A0 return (struct token*)addr;
> +#endif

Same here.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
