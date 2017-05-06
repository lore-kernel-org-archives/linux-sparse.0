From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v5] sparse: add support for _Static_assert
Date: Sat, 6 May 2017 16:22:04 -0400
Message-ID: <CANeU7Q=YnmjjRx5DQqg75o+rXYuyTR7L1tBOzjrBK5XOp3UuJw@mail.gmail.com>
References: <20170504160038.5328-1-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1140feac75cc71054ee0c2d3
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:35637 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdEFUWG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 May 2017 16:22:06 -0400
Received: by mail-io0-f169.google.com with SMTP id f102so31825622ioi.2
        for <linux-sparse@vger.kernel.org>; Sat, 06 May 2017 13:22:06 -0700 (PDT)
In-Reply-To: <20170504160038.5328-1-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

--001a1140feac75cc71054ee0c2d3
Content-Type: text/plain; charset=UTF-8

I play with it a bit.

On Thu, May 4, 2017 at 12:00 PM, Lance Richardson <lrichard@redhat.com> wrote:
> +static int match_static_assert(struct token *token)
> +{
> +       return token_type(token) == TOKEN_IDENT &&
> +              token->ident == &_Static_assert_ident;
> +}

I just find out there is already function match_ident() so use that
instead will make it clear it is compare against "_Static_assert".
Sorry I forget about this function earlier. I only find it when I play
with the code today.

>
>  struct statement *alloc_statement(struct position pos, int type)
>  {
> @@ -1864,13 +1877,17 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
>  static struct token *struct_declaration_list(struct token *token, struct symbol_list **list)
>  {
>         while (!match_op(token, '}')) {
> -               if (!match_op(token, ';'))
> -                       token = declaration_list(token, list);
> -               if (!match_op(token, ';')) {
> -                       sparse_error(token->pos, "expected ; at end of declaration");
> -                       break;
> +               if (match_static_assert(token))
> +                       token = parse_static_assert(token, NULL);
> +               else {
> +                       if (!match_op(token, ';'))
> +                               token = declaration_list(token, list);
> +                       if (!match_op(token, ';')) {
> +                               sparse_error(token->pos, "expected ; at end of declaration");
> +                               break;
> +                       }
> +                       token = token->next;

I reshape the code a bit to make it looks compact. Please see my
attachment patch.

> +static struct token *parse_static_assert(struct token *token, struct symbol_list **unused)
> +{
> +       struct expression *expr1 = NULL, *expr2 = NULL;
> +       int val;
> +
> +       token = expect(token->next, '(', "after _Static_assert");
> +       token = constant_expression(token, &expr1);
> +       token = expect(token, ',', "after first argument of _Static_assert");
> +       token = parse_expression(token, &expr2);
> +       token = expect(token, ')', "after second argument of _Static_assert");
> +
> +        token = expect(token, ';', "after _Static_assert()");
> +
> +       if (!expr1 || !expr2)
> +               return token;

OK,  this parsing does not complain about the following input:
_Static_assert(0, );
_Static_assert(, "");

I fix it in my patch. While I am there, I rename the expr1 to "cond".


>  /* Make a statement out of an expression */
>  static struct statement *make_statement(struct expression *expr)
>  {
> @@ -2389,11 +2436,14 @@ static struct token * statement_list(struct token *token, struct statement_list
>                         }
>                         stmt = alloc_statement(token->pos, STMT_DECLARATION);
>                         token = external_declaration(token, &stmt->declaration);
> +                       add_statement(list, stmt);
> +               } else if (match_static_assert(token)) {
> +                       token = parse_static_assert(token, NULL);

After take a closer look of the grimmer syntax. Static assert is
actually a declaration rather than a statement. So I merge this
two because external_declaration() can handle _Static_assert
parsing any way. Just need to pay attention it does not generate
resulting symbol node.

I rename the patch as V6. V5 does not apply to master any more.

Luc, can you take a look the V6 patch as well?

Thanks

Chris

--001a1140feac75cc71054ee0c2d3
Content-Type: text/x-patch; charset=US-ASCII;
	name="v6-sparse-add-support-for-_Static_assert.patch"
Content-Disposition: attachment;
	filename="v6-sparse-add-support-for-_Static_assert.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j2dpqqdh0

RnJvbSBwYXRjaHdvcmsgVGh1IE1heSAgNCAxNjowMDozOCAyMDE3CkNvbnRlbnQtVHlwZTogdGV4
dC9wbGFpbjsgY2hhcnNldD0idXRmLTgiCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDdiaXQKU3ViamVjdDogW3Y1XSBzcGFyc2U6IGFkZCBzdXBwb3J0IGZvciBf
U3RhdGljX2Fzc2VydApGcm9tOiBMYW5jZSBSaWNoYXJkc29uIDxscmljaGFyZEByZWRoYXQuY29t
PgpYLVBhdGNod29yay1JZDogOTcxMjI2NwpNZXNzYWdlLUlkOiA8MjAxNzA1MDQxNjAwMzguNTMy
OC0xLWxyaWNoYXJkQHJlZGhhdC5jb20+ClRvOiBsaW51eC1zcGFyc2VAdmdlci5rZXJuZWwub3Jn
CkRhdGU6IFRodSwgIDQgTWF5IDIwMTcgMTI6MDA6MzggLTA0MDAKClRoaXMgcGF0Y2ggaW50cm9k
dWNlcyBzdXBwb3J0IGZvciB0aGUgQzExIF9TdGF0aWNfYXNzZXJ0KCkgY29uc3RydWN0LgoKUGVy
IHRoZSBOMTUzOSBkcmFmdCBzdGFuZGFyZCwgdGhlIHN5bnRheCBjaGFuZ2VzIGZvciB0aGlzIGNv
bnN0cnVjdAppbmNsdWRlOgoKICAgIGRlY2xhcmF0aW9uOgogICAgICAgIDxkZWNsYXJhdGlvbi1z
cGVjaWZpZXJzPiA8aW5pdC1kZWNsYXJhdG9yLWxpc3Q+W29wdF0gOwogICAgICAgIDxzdGF0aWNf
YXNzZXJ0LWRlY2xhcmF0aW9uPgoKICAgIHN0cnVjdC1kZWNsYXJhdGlvbjoKICAgICAgICA8c3Bl
Y2lmaWVyLXF1YWxpZmllci1saXN0PiA8c3RydWN0LWRlY2xhcmF0b3ItbGlzdD5bb3B0XSA7CiAg
ICAgICAgPHN0YXRpY19hc3NlcnQtZGVjbGFyYXRpb24+CgogICAgc3RhdGljX2Fzc2VydC1kZWNs
YXJhdGlvbjoKICAgICAgICBfU3RhdGljX2Fzc2VydCAoIDxjb25zdGFudC1leHByZXNzaW9uPiAs
IDxzdHJpbmctbGl0ZXJhbD4gKSA7CgpTaWduZWQtb2ZmLWJ5OiBMYW5jZSBSaWNoYXJkc29uIDxs
cmljaGFyZEByZWRoYXQuY29tPgpBY2tlZC1ieTogTHVjIFZhbiBPb3N0ZW5yeWNrIDxsdWMudmFu
b29zdGVucnlja0BnbWFpbC5jb20+Ci0tLQp2NTogSW5jb3Jwb3JhdGVkIGZlZWRiYWNrIGZyb20g
Q2hyaXN0b3BoZXIgTGkgYW5kIEx1YyB2YW4gT29zdGVucnljazoKICAgIC0gTWFkZSBfU3RhdGlj
X2Fzc2VydCBhIHJlc2VydmVkIGlkZW50aWZpZXIKICAgIC0gU2ltcGxpZmllZCBjaGVjayBmb3Ig
X1N0YXRpY19hc3NlcnQga2V5d29yZCwgY29uc29saWRhdGVkIGludG8KICAgICAgYSBjb21tb24g
ZnVuY3Rpb24uCiAgICAtIEltcHJvdmVkIHRoZSAic3RhdGljIGFzc2VydCB3aXRoaW4gYSBmdW5j
dGlvbiBib2R5IiB0ZXN0IGNhc2UKICAgICAgYnkgYWRkaW5nIGEgc3RhdGljIGFzc2VydGlvbiBp
bnRlcm1pbmdsZWQgd2l0aCBjb2RlIGFuZCBhZGRpbmcKICAgICAgYSBzdGF0aWMgYXNzZXJ0aW9u
IHdpdGhpbiBhIGNvbXBvdW5kIHN0YXRlbWVudCBibG9jay4KICAgIC0gRml4ZWQgdXNlIG9mIGlu
aXRpYWxpemVkIHN0bXQgdmFyaWFibGUuCiAgICBUZXN0ZWQgYnkgdXNpbmcgc3BhcnNlIG9uIGVu
dGlyZSBrZXJuZWwgdHJlZSBhbmQgYSBzaW1pbGFybHktc2l6ZWQKICAgIGNvZGUgdHJlZSB3aGlj
aCBtYWtlcyB1c2Ugb2YgX1N0YXRpY19hc3NlcnQoKS4KCnY0OiBBZGRyZXNzZWQgZmVlZGJhY2ss
IHNpbXBsaWZpZWQgYW5kIHJlc3RydWN0dXJlZCB0byBiZXR0ZXIgbW9kZWwKICAgIGRlc2NyaXB0
aW9uIGluIGRyYWZ0IHN0YW5kYXJkLgoKdjM6CiAgICAtIFJlbW92ZWQgYm9ndXMgdGVzdCBjYXNl
IGludHJvZHVjZWQgaW4gdjIgKHN0YXRpYyBhc3NlcnRpb24gb24gc2l6ZW9mCiAgICAgIGEgc3Ry
dWN0dXJlIHdpdGhpbiB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgc3RydWN0dXJlKS4KCnYyOiAKICAg
IC0gQWRkZWQgYWRkaXRpb25hbCB0ZXN0IGNhc2VzLgogICAgLSBBZGRlZCBhZGRpdGlvbmFsIHZh
bGlkYXRpb24gZm9yIHBhcmFtZXRlcnMgdG8gX1N0YXRpY19hc3NlcnQoKS4KICAgIC0gUmV3b3Jr
ZWQgaW1wbGVtZW50YXRpb24gdG8gYXZvaWQgaW1wYWN0aW5nIHN0cnVjdC91bmlvbiBkZWZpbml0
aW9uCiAgICAgIGhhbmRsaW5nICggdGhlIHYxIGltcGxlbWVudGF0aW9uLCB3aGljaCB0cmVhdGVk
IF9TdGF0aWNfYXNzZXJ0KCkKICAgICAgYXMgYW4gTlNfVFlQRURFRiB0ZXJtLCBoYWQgdGhlIHVu
Zm9ydHVuYXRlIHNpZGUtZWZmZWN0IG9mCiAgICAgIGxlYXZpbmcgYW4gdW5uYW1lZCBmaWVsZCB3
aXRoIHVua25vd24gc2l6ZSBhdHRhY2hlZCB0byBzdHJ1Y3R1cmUKICAgICAgZGVmaW5pdGlvbnMg
d2hlbiBhIHN0YXRpYyBhc3NlcnQgd2FzIGluc2lkZSBhIHN0cnVjdHVyZSBkZWZpbml0aW9uKS4K
CiBpZGVudC1saXN0LmggICAgICAgICAgICAgICB8ICAxICsKIHBhcnNlLmMgICAgICAgICAgICAg
ICAgICAgIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LQogdmFsaWRhdGlvbi9zdGF0aWNfYXNzZXJ0LmMgfCA2NCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxMjMgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB2YWxpZGF0aW9uL3N0YXRpY19h
c3NlcnQuYwoKCgoKCgoKCgoKCgoKLS0tIHNwYXJzZS5jaHJpc2wub3JpZy9wYXJzZS5jCisrKyBz
cGFyc2UuY2hyaXNsL3BhcnNlLmMKQEAgLTczLDYgKzczLDcgQEAgc3RhdGljIHN0cnVjdCB0b2tl
biAqcGFyc2VfY29udGV4dF9zdGF0ZQogc3RhdGljIHN0cnVjdCB0b2tlbiAqcGFyc2VfcmFuZ2Vf
c3RhdGVtZW50KHN0cnVjdCB0b2tlbiAqdG9rZW4sIHN0cnVjdCBzdGF0ZW1lbnQgKnN0bXQpOwog
c3RhdGljIHN0cnVjdCB0b2tlbiAqcGFyc2VfYXNtX3N0YXRlbWVudChzdHJ1Y3QgdG9rZW4gKnRv
a2VuLCBzdHJ1Y3Qgc3RhdGVtZW50ICpzdG10KTsKIHN0YXRpYyBzdHJ1Y3QgdG9rZW4gKnRvcGxl
dmVsX2FzbV9kZWNsYXJhdGlvbihzdHJ1Y3QgdG9rZW4gKnRva2VuLCBzdHJ1Y3Qgc3ltYm9sX2xp
c3QgKipsaXN0KTsKK3N0YXRpYyBzdHJ1Y3QgdG9rZW4gKnBhcnNlX3N0YXRpY19hc3NlcnQoc3Ry
dWN0IHRva2VuICp0b2tlbiwgc3RydWN0IHN5bWJvbF9saXN0ICoqdW51c2VkKTsKIAogdHlwZWRl
ZiBzdHJ1Y3QgdG9rZW4gKmF0dHJfdChzdHJ1Y3QgdG9rZW4gKiwgc3RydWN0IHN5bWJvbCAqLAog
CQkJICAgICBzdHJ1Y3QgZGVjbF9zdGF0ZSAqKTsKQEAgLTMyOCw2ICszMjksMTAgQEAgc3RhdGlj
IHN0cnVjdCBzeW1ib2xfb3AgYXNtX29wID0gewogCS50b3BsZXZlbCA9IHRvcGxldmVsX2FzbV9k
ZWNsYXJhdGlvbiwKIH07CiAKK3N0YXRpYyBzdHJ1Y3Qgc3ltYm9sX29wIHN0YXRpY19hc3NlcnRf
b3AgPSB7CisJLnRvcGxldmVsID0gcGFyc2Vfc3RhdGljX2Fzc2VydCwKK307CisKIHN0YXRpYyBz
dHJ1Y3Qgc3ltYm9sX29wIHBhY2tlZF9vcCA9IHsKIAkuYXR0cmlidXRlID0gYXR0cmlidXRlX3Bh
Y2tlZCwKIH07CkBAIC00NjYsNiArNDcxLDkgQEAgc3RhdGljIHN0cnVjdCBpbml0X2tleXdvcmQg
ewogCXsgIl9fcmVzdHJpY3QiLAlOU19UWVBFREVGLCAub3AgPSAmcmVzdHJpY3Rfb3B9LAogCXsg
Il9fcmVzdHJpY3RfXyIsCU5TX1RZUEVERUYsIC5vcCA9ICZyZXN0cmljdF9vcH0sCiAKKwkvKiBT
dGF0aWMgYXNzZXJ0aW9uICovCisJeyAiX1N0YXRpY19hc3NlcnQiLCBOU19LRVlXT1JELCAub3Ag
PSAmc3RhdGljX2Fzc2VydF9vcCB9LAorCiAJLyogU3RvcmFnZSBjbGFzcyAqLwogCXsgImF1dG8i
LAlOU19UWVBFREVGLCAub3AgPSAmYXV0b19vcCB9LAogCXsgInJlZ2lzdGVyIiwJTlNfVFlQRURF
RiwgLm9wID0gJnJlZ2lzdGVyX29wIH0sCkBAIC02OTAsNyArNjk4LDYgQEAgc3RhdGljIGludCBT
RU5USU5FTF9BVFRSIG1hdGNoX2lkZW50cyhzdAogCXJldHVybiBuZXh0ICYmIHRva2VuLT5pZGVu
dCA9PSBuZXh0OwogfQogCi0KIHN0cnVjdCBzdGF0ZW1lbnQgKmFsbG9jX3N0YXRlbWVudChzdHJ1
Y3QgcG9zaXRpb24gcG9zLCBpbnQgdHlwZSkKIHsKIAlzdHJ1Y3Qgc3RhdGVtZW50ICpzdG10ID0g
X19hbGxvY19zdGF0ZW1lbnQoMCk7CkBAIC0xOTQyLDExICsxOTQ5LDE4IEBAIHN0YXRpYyBzdHJ1
Y3QgdG9rZW4gKmRlY2xhcmF0aW9uX2xpc3Qoc3QKIAlyZXR1cm4gdG9rZW47CiB9CiAKK3N0YXRp
YyBzdHJ1Y3QgdG9rZW4gKnN0YXRpY19hc3NlcnRfb3JfZGVjbGFyYXRpb25fbGlzdChzdHJ1Y3Qg
dG9rZW4gKnRva2VuLCBzdHJ1Y3Qgc3ltYm9sX2xpc3QgKipsaXN0KQoreworCWlmIChtYXRjaF9p
ZGVudCh0b2tlbiwgJl9TdGF0aWNfYXNzZXJ0X2lkZW50KSkKKwkJcmV0dXJuIHBhcnNlX3N0YXRp
Y19hc3NlcnQodG9rZW4sIE5VTEwpOworCXJldHVybiBkZWNsYXJhdGlvbl9saXN0KHRva2VuLCBs
aXN0KTsKK30KKwogc3RhdGljIHN0cnVjdCB0b2tlbiAqc3RydWN0X2RlY2xhcmF0aW9uX2xpc3Qo
c3RydWN0IHRva2VuICp0b2tlbiwgc3RydWN0IHN5bWJvbF9saXN0ICoqbGlzdCkKIHsKIAl3aGls
ZSAoIW1hdGNoX29wKHRva2VuLCAnfScpKSB7CiAJCWlmICghbWF0Y2hfb3AodG9rZW4sICc7Jykp
Ci0JCQl0b2tlbiA9IGRlY2xhcmF0aW9uX2xpc3QodG9rZW4sIGxpc3QpOworCQkJdG9rZW4gPSBz
dGF0aWNfYXNzZXJ0X29yX2RlY2xhcmF0aW9uX2xpc3QodG9rZW4sIGxpc3QpOwogCQlpZiAoIW1h
dGNoX29wKHRva2VuLCAnOycpKSB7CiAJCQlzcGFyc2VfZXJyb3IodG9rZW4tPnBvcywgImV4cGVj
dGVkIDsgYXQgZW5kIG9mIGRlY2xhcmF0aW9uIik7CiAJCQlicmVhazsKQEAgLTIwOTMsNiArMjEw
Nyw0MCBAQCBzdGF0aWMgc3RydWN0IHRva2VuICpwYXJzZV9hc21fZGVjbGFyYXRvCiAJcmV0dXJu
IHRva2VuOwogfQogCisKK3N0YXRpYyBzdHJ1Y3QgdG9rZW4gKnBhcnNlX3N0YXRpY19hc3NlcnQo
c3RydWN0IHRva2VuICp0b2tlbiwgc3RydWN0IHN5bWJvbF9saXN0ICoqdW51c2VkKQoreworCXN0
cnVjdCBleHByZXNzaW9uICpjb25kID0gTlVMTCwgKmZhaWxfc3RyaW5nID0gTlVMTDsKKwlpbnQg
dmFsOworCisJdG9rZW4gPSBleHBlY3QodG9rZW4tPm5leHQsICcoJywgImFmdGVyIF9TdGF0aWNf
YXNzZXJ0Iik7CisJdG9rZW4gPSBjb25zdGFudF9leHByZXNzaW9uKHRva2VuLCAmY29uZCk7CisJ
aWYgKCFjb25kKQorCQlzcGFyc2VfZXJyb3IodG9rZW4tPnBvcywgImV4cGVjdCBleHByZXNzaW9u
IGJlZm9yZSAnJXMnIHRva2VuIiwgc2hvd190b2tlbih0b2tlbikpOworCXRva2VuID0gZXhwZWN0
KHRva2VuLCAnLCcsICJhZnRlciBmaXJzdCBhcmd1bWVudCBvZiBfU3RhdGljX2Fzc2VydCIpOwor
CXRva2VuID0gcGFyc2VfZXhwcmVzc2lvbih0b2tlbiwgJmZhaWxfc3RyaW5nKTsKKwlpZiAoIWZh
aWxfc3RyaW5nKQorCQlzcGFyc2VfZXJyb3IodG9rZW4tPnBvcywgImV4cGVjdCBleHByZXNzaW9u
IGJlZm9yZSAnJXMnIHRva2VuIiwgc2hvd190b2tlbih0b2tlbikpOworCXRva2VuID0gZXhwZWN0
KHRva2VuLCAnKScsICJhZnRlciBzZWNvbmQgYXJndW1lbnQgb2YgX1N0YXRpY19hc3NlcnQiKTsK
KworCWV4cGVjdCh0b2tlbiwgJzsnLCAiYWZ0ZXIgX1N0YXRpY19hc3NlcnQoKSIpOworCisJaWYg
KCFjb25kIHx8ICFmYWlsX3N0cmluZykKKwkJcmV0dXJuIHRva2VuOworCisJdmFsID0gY29uc3Rf
ZXhwcmVzc2lvbl92YWx1ZShjb25kKTsKKworCWlmIChmYWlsX3N0cmluZy0+dHlwZSAhPSBFWFBS
X1NUUklORykgeworCQlzcGFyc2VfZXJyb3IoZmFpbF9zdHJpbmctPnBvcywgImJhZCBzdHJpbmcg
bGl0ZXJhbCIpOworCQlyZXR1cm4gdG9rZW47CisJfQorCisJaWYgKGNvbmQtPnR5cGUgPT0gRVhQ
Ul9WQUxVRSAmJiAhdmFsKQorCQlzcGFyc2VfZXJyb3IoY29uZC0+cG9zLCAic3RhdGljIGFzc2Vy
dGlvbiBmYWlsZWQ6ICVzIiwKKwkJCQlzaG93X3N0cmluZyhmYWlsX3N0cmluZy0+c3RyaW5nKSk7
CisJcmV0dXJuIHRva2VuOworfQorCiAvKiBNYWtlIGEgc3RhdGVtZW50IG91dCBvZiBhbiBleHBy
ZXNzaW9uICovCiBzdGF0aWMgc3RydWN0IHN0YXRlbWVudCAqbWFrZV9zdGF0ZW1lbnQoc3RydWN0
IGV4cHJlc3Npb24gKmV4cHIpCiB7CkBAIC0yNDc0LDEzICsyNTIyLDE4IEBAIHN0YXRpYyBzdHJ1
Y3QgdG9rZW4gKiBzdGF0ZW1lbnRfbGlzdChzdHIKIAkJCWJyZWFrOwogCQlpZiAobWF0Y2hfb3Ao
dG9rZW4sICd9JykpCiAJCQlicmVhazsKLQkJaWYgKGxvb2t1cF90eXBlKHRva2VuKSkgeworCQlp
ZiAobG9va3VwX3R5cGUodG9rZW4pIHx8IG1hdGNoX2lkZW50KHRva2VuLCAmX1N0YXRpY19hc3Nl
cnRfaWRlbnQpKSB7CisJCQlzdHJ1Y3Qgc3ltYm9sX2xpc3QgKmRlY2xhcmF0aW9uID0gTlVMTDsK
KwogCQkJaWYgKHNlZW5fc3RhdGVtZW50KSB7CiAJCQkJd2FybmluZyh0b2tlbi0+cG9zLCAibWl4
aW5nIGRlY2xhcmF0aW9ucyBhbmQgY29kZSIpOwogCQkJCXNlZW5fc3RhdGVtZW50ID0gMDsKIAkJ
CX0KKwkJCXRva2VuID0gZXh0ZXJuYWxfZGVjbGFyYXRpb24odG9rZW4sICZkZWNsYXJhdGlvbiwg
TlVMTCk7CisJCQlpZiAoIWRlY2xhcmF0aW9uKQorCQkJCWNvbnRpbnVlOwogCQkJc3RtdCA9IGFs
bG9jX3N0YXRlbWVudCh0b2tlbi0+cG9zLCBTVE1UX0RFQ0xBUkFUSU9OKTsKLQkJCXRva2VuID0g
ZXh0ZXJuYWxfZGVjbGFyYXRpb24odG9rZW4sICZzdG10LT5kZWNsYXJhdGlvbiwgTlVMTCk7CisJ
CQlzdG10LT5kZWNsYXJhdGlvbiA9IGRlY2xhcmF0aW9uOwogCQl9IGVsc2UgewogCQkJc2Vlbl9z
dGF0ZW1lbnQgPSBXZGVjbGFyYXRpb25hZnRlcnN0YXRlbWVudDsKIAkJCXRva2VuID0gc3RhdGVt
ZW50KHRva2VuLCAmc3RtdCk7CkBAIC0yODE5LDcgKzI4NzIsNyBAQCBzdHJ1Y3QgdG9rZW4gKmV4
dGVybmFsX2RlY2xhcmF0aW9uKHN0cnVjCiAJdW5zaWduZWQgbG9uZyBtb2Q7CiAJaW50IGlzX3R5
cGVkZWY7CiAKLQkvKiBUb3AtbGV2ZWwgaW5saW5lIGFzbT8gKi8KKwkvKiBUb3AtbGV2ZWwgaW5s
aW5lIGFzbSBvciBzdGF0aWMgYXNzZXJ0aW9uPyAqLwogCWlmICh0b2tlbl90eXBlKHRva2VuKSA9
PSBUT0tFTl9JREVOVCkgewogCQlzdHJ1Y3Qgc3ltYm9sICpzID0gbG9va3VwX2tleXdvcmQodG9r
ZW4tPmlkZW50LCBOU19LRVlXT1JEKTsKIAkJaWYgKHMgJiYgcy0+b3AtPnRvcGxldmVsKQotLS0g
c3BhcnNlLmNocmlzbC5vcmlnL2lkZW50LWxpc3QuaAorKysgc3BhcnNlLmNocmlzbC9pZGVudC1s
aXN0LmgKQEAgLTE2LDYgKzE2LDcgQEAgSURFTlRfUkVTRVJWRUQoZm9yKTsKIElERU5UX1JFU0VS
VkVEKHdoaWxlKTsKIElERU5UX1JFU0VSVkVEKGRvKTsKIElERU5UX1JFU0VSVkVEKGdvdG8pOwor
SURFTlRfUkVTRVJWRUQoX1N0YXRpY19hc3NlcnQpOwogCiAvKiBDIHR5cGVuYW1lcy4gVGhleSBn
ZXQgbWFya2VkIGFzIHJlc2VydmVkIHdoZW4gaW5pdGlhbGl6ZWQgKi8KIElERU5UKHN0cnVjdCk7
Ci0tLSBzcGFyc2UuY2hyaXNsLm9yaWcvdmFsaWRhdGlvbi9zdGF0aWNfYXNzZXJ0LmMKKysrIHNw
YXJzZS5jaHJpc2wvdmFsaWRhdGlvbi9zdGF0aWNfYXNzZXJ0LmMKQEAgLTAsMCArMSw2NCBAQAor
X1N0YXRpY19hc3NlcnQoMSwgImdsb2JhbCBvayIpOworCitzdHJ1Y3QgZm9vIHsKKwlfU3RhdGlj
X2Fzc2VydCgxLCAic3RydWN0IG9rIik7Cit9OworCit2b2lkIGJhcih2b2lkKQoreworCV9TdGF0
aWNfYXNzZXJ0KDEsICIgZnVuYzEgb2siKTsKKwlpbnQgaTsKKwlpID0gMDsKKwlfU3RhdGljX2Fz
c2VydCgxLCAiIGZ1bmMyIG9rIik7CisKKyAgICAgICAgaWYgKDEpIHsKKwkgICBfU3RhdGljX2Fz
c2VydCgxLCAiIGZ1bmMzIG9rIik7CisJfQorfQorCitfU3RhdGljX2Fzc2VydCgwLCAiZXhwZWN0
ZWQgYXNzZXJ0aW9uIGZhaWx1cmUiKTsKKworc3RhdGljIGludCBmOworX1N0YXRpY19hc3NlcnQo
ZiwgIm5vbi1jb25zdGFudCBleHByZXNzaW9uIik7CisKK3N0YXRpYyBpbnQgKnA7CitfU3RhdGlj
X2Fzc2VydChwLCAibm9uLWludGVnZXIgZXhwcmVzc2lvbiIpOworCitfU3RhdGljX2Fzc2VydCgw
LjEsICJmbG9hdCBleHByZXNzaW9uIik7CisgICAgICAgIAorX1N0YXRpY19hc3NlcnQoITAgPT0g
MSwgIm5vbi10cml2aWFsIGV4cHJlc3Npb24iKTsKKyAgICAgICAgCitzdGF0aWMgY2hhciBhcnJh
eVs0XTsKK19TdGF0aWNfYXNzZXJ0KHNpemVvZihhcnJheSkgPT0gNCwgInNpemVvZiBleHByZXNz
aW9uIik7CisgICAgICAgIAorc3RhdGljIGNvbnN0IGNoYXIgbm9uX2xpdGVyYWxfc3RyaW5nW10g
PSAibm9uIGxpdGVyYWwgc3RyaW5nIjsKK19TdGF0aWNfYXNzZXJ0KDAsIG5vbl9saXRlcmFsX3N0
cmluZyk7CisKK19TdGF0aWNfYXNzZXJ0KDEgLyAwLCAiaW52YWxpZCBleHByZXNzaW9uOiBzaG91
bGQgbm90IHNob3cgdXA/Iik7CisKK3N0cnVjdCBzIHsKKwljaGFyIGFyclsxNl07CisJX1N0YXRp
Y19hc3NlcnQoMSwgImluc2lkZSBzdHJ1Y3QiKTsKK307CisKK3VuaW9uIHUgeworCWNoYXIgYzsK
KwlpbnQgIGk7CisJX1N0YXRpY19hc3NlcnQoMSwgImluc2lkZSB1bmlvbiIpOworfTsKKworX1N0
YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBzKSA9PSAxNiwgInNpemVvZiBhc3NlcnRpb24iKTsK
KworLyoKKyAqIGNoZWNrLW5hbWU6IHN0YXRpYyBhc3NlcnRpb24KKyAqCisgKiBjaGVjay1lcnJv
ci1zdGFydAorc3RhdGljX2Fzc2VydC5jOjE5OjE2OiBlcnJvcjogc3RhdGljIGFzc2VydGlvbiBm
YWlsZWQ6ICJleHBlY3RlZCBhc3NlcnRpb24gZmFpbHVyZSIKK3N0YXRpY19hc3NlcnQuYzoyMjox
NjogZXJyb3I6IGJhZCBjb25zdGFudCBleHByZXNzaW9uCitzdGF0aWNfYXNzZXJ0LmM6MjU6MTY6
IGVycm9yOiBiYWQgY29uc3RhbnQgZXhwcmVzc2lvbgorc3RhdGljX2Fzc2VydC5jOjI3OjE2OiBl
cnJvcjogYmFkIGNvbnN0YW50IGV4cHJlc3Npb24KK3N0YXRpY19hc3NlcnQuYzozNToxOTogZXJy
b3I6IGJhZCBzdHJpbmcgbGl0ZXJhbAorc3RhdGljX2Fzc2VydC5jOjM3OjE4OiBlcnJvcjogYmFk
IGNvbnN0YW50IGV4cHJlc3Npb24KKyAqIGNoZWNrLWVycm9yLWVuZAorICovCisK
--001a1140feac75cc71054ee0c2d3--
