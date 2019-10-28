From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
Date: Mon, 28 Oct 2019 10:59:47 -0700
Message-ID: <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
         <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, 2019-10-28 at 18:37 +0100, Miguel Ojeda wrote:
> On Mon, Oct 28, 2019 at 12:43 PM Joe Perches <joe@perches.com> wrote:
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 72393a..b8c2145 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -5,27 +5,27 @@
> >  #ifndef __ASSEMBLY__
> > 
> >  #ifdef __CHECKER__
> > -# define __user                __attribute__((noderef, address_space(1)))
[]
> Just in case: for these ones (i.e. __CHECKER__), did you check if
> sparse handles this syntax? (I don't recall myself if it does).
> 
> Other than that, thanks for the cleanup too! I can pick it up in the
> the compiler-attributes tree and put it in -next.

Thanks for asking and no, I did  not until just now.
Turns out sparse does _not_ handle these changes and
the checking fails for these __<changes>__.

sparse would have to update parse.c or the __CHECKER__
changes would need to be reverted.

Perhaps update parse.c like:
---
 parse.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/parse.c b/parse.c
index 48a63..4464e 100644
--- a/parse.c
+++ b/parse.c
@@ -549,13 +549,19 @@ static struct init_keyword {
 	{ "aligned",	NS_KEYWORD, .op = &aligned_op },
 	{ "__aligned__",NS_KEYWORD, .op = &aligned_op },
 	{ "nocast",	NS_KEYWORD,	MOD_NOCAST,	.op = &attr_mod_op },
+	{ "__nocast__",	NS_KEYWORD,	MOD_NOCAST,	.op = &attr_mod_op },
 	{ "noderef",	NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
+	{ "__noderef__",NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
 	{ "safe",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
+	{ "__safe__",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
 	{ "force",	NS_KEYWORD,	.op = &attr_force_op },
+	{ "__force__",	NS_KEYWORD,	.op = &attr_force_op },
 	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
 	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
+	{ "__address_space__",NS_KEYWORD,	.op = &address_space_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
+	{ "__context__",NS_KEYWORD,	.op = &context_op },
 	{ "designated_init",	NS_KEYWORD,	.op = &designated_init_op },
 	{ "__designated_init__",	NS_KEYWORD,	.op = &designated_init_op },
 	{ "transparent_union",	NS_KEYWORD,	.op = &transparent_union_op },
