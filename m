From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] Avoid reusing string buffer when doing string expansion
Date: Wed, 4 Feb 2015 08:38:19 -0800
Message-ID: <CANeU7Qn2yTRxh9VzGuSYE8hGtWvVVMUvfPGQ7212NsU_eVt=vg@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204020059.GA7069@macpro.local>
	<CANeU7QnYCGWK0LH8+f=bDSbdPHfDvjdRtmUQF5R8j6h9fDBp2g@mail.gmail.com>
	<20150204062250.GA9989@macbook.lan>
	<CANeU7Q=xw-Hq7Nd+UOGb-EUbQSovzwpx1Zm4pP9XGnS4eaGb2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:60721 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966389AbbBDQiT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 11:38:19 -0500
Received: by mail-qc0-f172.google.com with SMTP id x3so2100676qcv.3
        for <linux-sparse@vger.kernel.org>; Wed, 04 Feb 2015 08:38:19 -0800 (PST)
In-Reply-To: <CANeU7Q=xw-Hq7Nd+UOGb-EUbQSovzwpx1Zm4pP9XGnS4eaGb2A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 4, 2015 at 12:01 AM, Christopher Li <sparse@chrisli.org> wrote:
>
> When the lexer process the escape char, you did not know the string
> is wide char or not. That can be changed after the macro expansion.

With that in mind, we can't actually perform the escape char substitution
before the pre-processor stage.

Here is an untested patch adding the immutable string to macro body.
I need to double check if the macro arguments needs it as well.

Can you guys try it on the test case you have?

Thanks

Chris

diff --git a/char.c b/char.c
index 08ca223..7f86b8a 100644
--- a/char.c
+++ b/char.c
@@ -123,7 +123,7 @@ struct token *get_string_constant(struct token
*token, struct expression *expr)
                len = MAX_STRING;
        }

-       if (len >= string->length)      /* can't cannibalize */
+       if (string->immutable || len >= string->length) /* can't cannibalize */
                string = __alloc_string(len+1);
        string->length = len+1;
        memcpy(string->data, buffer, len);
diff --git a/pre-process.c b/pre-process.c
index 1aa3d2c..57d84b9 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1259,8 +1259,16 @@ static struct token *parse_expansion(struct
token *expansion, struct token *argl
                } else {
                        try_arg(token, TOKEN_MACRO_ARGUMENT, arglist);
                }
-               if (token_type(token) == TOKEN_ERROR)
+               switch (token_type(token)) {
+               case TOKEN_ERROR:
                        goto Earg;
+
+               case TOKEN_STRING:
+               case TOKEN_WIDE_STRING:
+                       token->string->immutable = 1;
+               default:
+                       ;
+               }
        }
        token = alloc_token(&expansion->pos);
        token_type(token) = TOKEN_UNTAINT;
diff --git a/token.h b/token.h
index 8dbd80f..af66b2b 100644
--- a/token.h
+++ b/token.h
@@ -164,7 +164,8 @@ enum special_token {
 };

 struct string {
-       unsigned int length;
+       unsigned int length:31;
+       unsigned int immutable:1;
        char data[];
 };
