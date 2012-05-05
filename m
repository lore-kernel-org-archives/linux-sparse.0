From: Christopher Li <sparse@chrisli.org>
Subject: Re: dependency tee from c parser entities downto token
Date: Sat, 5 May 2012 04:12:37 -0700
Message-ID: <CANeU7QnNemo=iyx3+VJBgEzf4kOacxOx9JTsbu5Of46+3NkAJA@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
	<CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
	<CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
	<4FA38635.5060300@gaisler.com>
	<CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
	<4FA3B14A.3070609@gaisler.com>
	<CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com>
	<4FA44E3D.6020504@gmail.com>
	<CANeU7QmzTDarO9xD7NiRsaSasQnVQug6LFCCp9ud0vuBcekS8Q@mail.gmail.com>
	<4FA4EAD6.1040206@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5abbe59763f04bf481d1f
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46056 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab2EELMj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 5 May 2012 07:12:39 -0400
Received: by wgbdr13 with SMTP id dr13so3458020wgb.1
        for <linux-sparse@vger.kernel.org>; Sat, 05 May 2012 04:12:38 -0700 (PDT)
In-Reply-To: <4FA4EAD6.1040206@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

--001636c5abbe59763f04bf481d1f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, May 5, 2012 at 1:54 AM, Konrad Eisele <eiselekd@gmail.com> wrote:
>>
>>
>> That is much better. There is two separate problem here.
>> One is keep track of all the macro expand history so you can
>> trace back the token back to the original form. I believe my
>> description of the macro_expand hook should take care of that.
>
>
> Ok, I'll try to implement it the way you suggest, coding macro-
> expansion into token.pos See (Concerning (2)). Tell me weather
> I can start implementing the scheme stated below (at least for
> (Concerning (2)). I would add 3 hooks as stated in "Conclusion:" of
> section "Concerning (2)". Can you give the ok to go?
>
> Concerning (1): You didnt comment on this point.

Oh, obviously you can register the preprocess hook to notifify
of the ifdef and include. I consider adding this kind of the call back
function less invasive because program that only use the stander
preprocessor don't need to pay the price for it.

I attach a patch I am playing with the macro expand hook ideas.
It compiles but I haven't did any more test beyond that.
Feel free to use or modify it as you see fit.


> ------------------------------------------------
>
> I would need a list-based-pushdown-stack. Each entry would
> register calls to lookup_macro() when inside a # preprocessor
> line. Then an mechanism has to be implemented to tag each
> token with an entry in the pushdown stack (which builds up a
> tree). I guess that you dont want a pointer in struct token :-)
> so maybe the pushdown stack can define start-pos and when popped
> end-pos and use these "ranges" to match tokens.

I consider how to track the the macro dependency belongs to
internal behaviour of the shrink program. Spase is a library used
by this program. I want to make sure the API provide by spase
library is good enough information to allow dependency analyse.

As program that call into the sparse library, I don't have strong
opinion on how those program should implement. I care more
about the plumbing part of the sparse library, what API sparse
should provide to enable this kind of analyse.

> I would need hooks for this in the # preprocessor line locations.

Sure. Add it as one of the preprocessor hooks.

>
> Concerning (2): Macro expansion trace using token.<pos>
> -------------------------------------------------------
>
> I've thought about how to fit in macro_expand and stuffing
> macro trace into <pos>. Below is my sketch how I would record
> a macro expansion. p[] is the array of preprocessor-"lines",
> rather, it is an array of PP_struct (see below) with extra info
> needed for each line. PP_struct.copy is the copy of the array of
> tokens involved.
>
> Annotation: p[x] denotes the stuffing of the macrotrace into
> position.stream=3D=3Dpreprocess,position.line=3D=3Dpp-line.
> Tokenlists are written with "." between: tok0 . tok1 . ...
> Under the tokenlists I have written below each token its
> token.pos in p[x] notation, when token.pos is from file-scope
> I have written a range, i.e [a.h:1:23..a.h:1:45] so not to
> have write it for each token.

Again, as long as it is part of the program and not the sparse
library. You are relative free to chose your implementation
within your program. It should not have impact on other
program that use sparse library any way. I use <pos> to make
a point that macro_expand hook can work.

I am not sure I understand your range representation yet.

To be continue...

Chris


>
> Note that a reference to p[] in p[x] notation only references
> the "start" of the =A0PP_struct.copy. An uique identification
> of the "source" token might not always be possible because
> of disambiguities, so when doing a copy of the =A0tokens in
> PP_struct.copy I might use an extended version of struct token
> to also include an offset.
>
> ----- file a.h start -----
> #define D0(d0a0,d0a1) 1 D1(d0a0) 2 D2(d0a1) 3
> #define D1(d1a0) 4 d1a0 5
> #define D2(d2a0) 6 d2a0 7
> #define D3(d3a0) 8 d3a0 9
> D0(D3(10),11)
> ----- file a.h end =A0 .....
>
> Preprocessor output (gcc -E a.h): "1 4 8 10 9 5 2 6 11 7 3"
>
> PreProcessor macro trace on p[]:
>
> p[0]:mdefn_body[D0] =A0 =A0 :1.D1.(.d0a0.).2.D2.(.d0a1.).3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ a.h:1:23 =A0 =A0 .. =A0=
 a.h:1:45]
> p[1]:mdefn_body[D1] =A0 =A0 :4 =A0 . =A0 d1a0 =A0 . =A0 =A05
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ a.h:2:18..a.h:2:25]
> p[2]:mdefn_body[D2] =A0 =A0 :6 =A0 . =A0 d2a0 =A0 . =A0 =A07
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ a.h:3:18..a.h:3:25]
> p[3]:mdefn_body[D3] =A0 =A0 :8 =A0 . =A0 d3a0 =A0 . =A0 =A09
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ a.h:4:18..a.h:4:25]
> p[4]:minst_arg0[D0] =A0 =A0 :D3 =A0. ( =A0. =A0 10 . )
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ a.h:5:4..a.h:5:9]
> p[5]:minst_arg1[D0] =A0 =A0 :11
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [a.h:5:11]
> p[6]:minst_arg0[D3] =A0 =A0 :10
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p[4]
> p[7]:(args)expand[p[3]] :8 =A0 =A0. =A010 =A0 . =A09
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p[3] =A0 =A0p[4] =A0 =A0p=
[3]
> p[8]:minst_arg0[d2] =A0 =A0 :11
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p[5]
> p[9]:(body)expand[p[2]] :6 =A0 . =A0 11 =A0 . =A0 =A07
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p[2] =A0 =A0p[5] =A0 =A0 =
=A0p[2]
> p[10]:(body)expand[p[0]]:1 =A0.4 =A0.8 =A0.10 .9 =A0.5 =A0.2 =A0.6 =A0.11=
 .7 =A0.3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p[0]p[1]p[7]p[7]p[7]p[1]p=
[0]p[9]p[9]p[9]p[0]
>
>
> p[0]-p[3] are build up when the macro is defined.
> =A0 =A0 =A0 =A0 =A0A p[] entry is needed to destinguish between
> =A0 =A0 =A0 =A0 =A0the different sources of tokens.
> p[4],p[5] is build in collect_arguments() for D0(D3(10),11)
> p[6] =A0 =A0 =A0is build in collect_arguments() for D3(10)
> p[7] =A0 =A0 =A0is build in call to macro_expand() hook with flag that
> =A0 =A0 =A0 =A0 =A0it is a (args)expand
> p[8] =A0 =A0 =A0is build in collect_arguments() for D2(11)
> =A0 =A0 =A0 =A0 =A0(inside D0's expansion
> p[9] =A0 =A0 =A0is build in call to macro_expand() hook with flag that
> =A0 =A0 =A0 =A0 =A0it is a (body)expand (of D2)
> p[10] =A0 =A0 is build in call to macro_expand() hook with flag that
> =A0 =A0 =A0 =A0 =A0it is a (body)expand (of D0)
>
> PP_struct {
> =A0 =A0 =A0 =A0 =A0enum {minst_arg, expand_body, expand_arg, mdef_body} t=
yp;
> =A0 =A0 =A0 =A0 =A0uint argidx;
> =A0 =A0 =A0 =A0 =A0struct symbol *macro;
> =A0 =A0 =A0 =A0 =A0struct token copy[];
> };
>
> Conclusion:
> -----------
> Apart from the macro_expand() hook I also need hooks
> in macro definition and also in collect_arguments() or expand().
>
>
> Concerning (3) How to connect (1) and (2) to the AST
> ----------------------------------------------------
>
> can maybe wait for later iteration. There are more complex parts
> involved...
>
>
>
>>
>> Now how to connect the AST tree with those information is a
>> very good question. Notice the symbol->aux pointer? That is
>> the place to attach extra context or back end related data
>> to symbols.
>>
>> Because each symbol has "pos" and "endpos". If the symbol
>> is expand from macro, using the previous scheme, the pos
>> should point to a line in the "<pre-processor>" stream.
>>
>> However, if the macro expand is happen between "pos" and
>> "endpos", you will not able to access the token that contain
>> the macro expand "pos" easily.
>>
>> For that, we could, just thinking it out loud, add a parser
>> hook for declares when a symbol is complete building.
>> That would a very small and straight forward change.
>> If the hook is not NULL, the call back function will be call
>> with the symbol that just get defined, and the start and end
>> token of that symbol.
>>
>> So your dependence program just need to register the
>> symbol parsing hook. In side the call back function, walk
>> the token from start to end. Look up macro expand information
>> is needed. Build up the dependency struct and store that in
>> symbol->aux.
>>
>> BTW, unrelated to this patch, I can see other program might
>> be able to use the same parser hook to perform source code
>> transformations as well.
>>
>> Make sense? In this way, you don't even need the hash
>> table to attach a context into the token. You can get it directly
>> from symbol->aux.
>>
>>> In my patch I have modeled (2) using 2 structs:
>>> struct macro_expansion {
>>> =A0 =A0 =A0 =A0int nargs;
>>> =A0 =A0 =A0 =A0struct symbol *sym;
>>> =A0 =A0 =A0 =A0struct token *m;
>>> =A0 =A0 =A0 =A0struct arg args[0];
>>> };
>>> struct tok_macro_dep {
>>> =A0 =A0 =A0 =A0struct macro_expansion *m;
>>> =A0 =A0 =A0 =A0unsigned int argi;
>>> =A0 =A0 =A0 =A0unsigned int isbody : 1;
>>> =A0 =A0 =A0 =A0unsigned int visited : 1;
>>> };
>>> Each token from a macro expansion gets tagged with
>>> tok_macro_dep. If it is an macro argument,<argi> =A0shows the
>>> index, if it is from the macro body<isbody> =A0is 1.
>>> Now, I didnt already think about special cases like
>>> token concaternation, even more data is needed to
>>> model this. Also when an macro argument is again used as an
>>> macro argument inside the body expansion, then I kindof
>>> loose the chain: I would also need a "token *dup_of" pointer
>>> to point to the original token that the token is a copy
>>> of (when arguments are created...) etc.
>>>
>>> I have read your macro_expand() hook idea, however
>>> when I understand it right you want to reuse position.stream and
>>> position.line as a kind of pointer (to save the extra 4 bytes).
>>> (Your goal is to minimize codebase change, however I wonder
>>> weather you dont change semantic of struct position and then
>>> need to change the code that uses struct position anyway...)
>>
>>
>> Nope, because the position.stream change is only happen on
>> your dependency analyse program. It is the dependency program
>> register the hook to it. This behaviour is private to the dependency
>> analyse program. Other program that use sparse library don't see
>> it at all, because they don't register macro_expand hooks to perform
>> those stream manipulations. It will receive the exact AST as before.
>>
>>> Maybe it is possible like this...I doubt it, where should
>>> all the extra context, that each token has, be saved and
>>> extracted from? using that sheme...
>>
>>
>> Two places, one is symbol->aux. Also the macro_expand
>> can be lookup by pos->line. That will index into the macro_expand
>> array which store the context.
>>
>> Having this two should be enough to put the exact same
>> dependency result as you are doing right now.
>>
>>> Maybe it is possible but I dont want to have as a design
>>> goal to save 4 bytes (I'd use the void *custom sheme to
>>> save all my extra data, also the pointers to tokens to
>>> "sit around") and adujust everything else to
>>> that. The consequence is that the code-complexity would
>>> grow on the other end.
>>
>>
>> It is not only about saving 4 bytes. It is about other program
>> don't have to suck in the full token struct if they don't need to.
>> It is about re-usable macro hooks and parser hooks that
>> external program can do more fancy stuff like source code transformation=
s
>> without impacting the other user of the sparse lib.
>>
>>> Here is my compromise then:
>>> Keep the orignial "pos". But still grant me for
>>> each struct a "void *custom" pointer that I can use
>>> to store extradata i.e. pointer to token.
>>
>>
>> symbol->aux.
>>
>> Chris
>>
>

--001636c5abbe59763f04bf481d1f
Content-Type: application/octet-stream; name="0001-macro-expand-hook.patch"
Content-Disposition: attachment; filename="0001-macro-expand-hook.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1uipd9w0

RnJvbSBkZDljMzA4NTQzZGE1MzEzOGQxMmJiMDQyNjFkNjJiOGFkYzExMmE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgpE
YXRlOiBTYXQsIDUgTWF5IDIwMTIgMDM6MDk6MTggLTA3MDAKU3ViamVjdDogW1BBVENIXSBtYWNy
byBleHBhbmQgaG9vawoKLS0tCiBwcmUtcHJvY2Vzcy5jIHwgICAgNCArKysrCiB0b2tlbi5oICAg
ICAgIHwgICAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcHJlLXByb2Nlc3MuYyBiL3ByZS1wcm9jZXNzLmMKaW5k
ZXggOGExNmY4Yi4uNjNjZDUwOSAxMDA2NDQKLS0tIGEvcHJlLXByb2Nlc3MuYworKysgYi9wcmUt
cHJvY2Vzcy5jCkBAIC0zMCw2ICszMCw4IEBACiAKIHN0YXRpYyBpbnQgZmFsc2VfbmVzdGluZyA9
IDA7CiAKK3N0cnVjdCBwcmVwcm9jZXNzX2hvb2sgKnByZXByb2Nlc3NfaG9vayA9IE5VTEw7CisK
ICNkZWZpbmUgSU5DTFVERVBBVEhTIDMwMAogY29uc3QgY2hhciAqaW5jbHVkZXBhdGhbSU5DTFVE
RVBBVEhTKzFdID0gewogCSIiLApAQCAtNjI1LDYgKzYyNyw4IEBAIHN0YXRpYyBpbnQgZXhwYW5k
KHN0cnVjdCB0b2tlbiAqKmxpc3QsIHN0cnVjdCBzeW1ib2wgKnN5bSkKIAogCWxhc3QgPSB0b2tl
bi0+bmV4dDsKIAl0YWlsID0gc3Vic3RpdHV0ZShsaXN0LCBzeW0tPmV4cGFuc2lvbiwgYXJncyk7
CisJaWYgKHByZXByb2Nlc3NfaG9vayAmJiBwcmVwcm9jZXNzX2hvb2stPmV4cGFuZCkKKwkJcHJl
cHJvY2Vzc19ob29rLT5leHBhbmQodG9rZW4sIGxpc3QsIHRhaWwpOwogCSp0YWlsID0gbGFzdDsK
IAogCXJldHVybiAwOwpkaWZmIC0tZ2l0IGEvdG9rZW4uaCBiL3Rva2VuLmgKaW5kZXggY2QyOTIz
My4uMjM0NDkzMiAxMDA2NDQKLS0tIGEvdG9rZW4uaAorKysgYi90b2tlbi5oCkBAIC0xNzEsNiAr
MTcxLDEwIEBAIHN0cnVjdCB0b2tlbiB7CiAJfTsKIH07CiAKK3N0cnVjdCBwcmVwcm9jZXNzX2hv
b2sgeworCXZvaWQgKCpleHBhbmQpKHN0cnVjdCB0b2tlbiAqbWFjcm8sIHN0cnVjdCB0b2tlbiAq
KnJlcGxhY2UsIHN0cnVjdCB0b2tlbiAqKnJlcGxhY2VfdGFpbCk7Cit9OworCiAjZGVmaW5lIE1B
WF9TVFJJTkcgNDA5NQogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCB0b2tlbiAqY29udGFpbmluZ190
b2tlbihzdHJ1Y3QgdG9rZW4gKipwKQpAQCAtMTg4LDYgKzE5Miw3IEBAIHN0YXRpYyBpbmxpbmUg
c3RydWN0IHRva2VuICpjb250YWluaW5nX3Rva2VuKHN0cnVjdCB0b2tlbiAqKnApCiAgKi8KIGV4
dGVybiBzdHJ1Y3QgdG9rZW4gZW9mX3Rva2VuX2VudHJ5OwogI2RlZmluZSBlb2ZfdG9rZW4oeCkg
KCh4KSA9PSAmZW9mX3Rva2VuX2VudHJ5KQorZXh0ZXJuIHN0cnVjdCBwcmVwcm9jZXNzX2hvb2sg
KnByZXByb2Nlc3NfaG9vazsKIAogZXh0ZXJuIGludCBpbml0X3N0cmVhbShjb25zdCBjaGFyICos
IGludCBmZCwgY29uc3QgY2hhciAqKm5leHRfcGF0aCk7CiBleHRlcm4gY29uc3QgY2hhciAqc3Ry
ZWFtX25hbWUoaW50IHN0cmVhbSk7Ci0tIAoxLjcuNy42Cgo=
--001636c5abbe59763f04bf481d1f--
