Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B9C4727C
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 18:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD302076B
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 18:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgI3SeE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 14:34:04 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:49740 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725771AbgI3SeE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 14:34:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D49511803009B;
        Wed, 30 Sep 2020 18:34:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: low83_630953527195
X-Filterd-Recvd-Size: 13384
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 18:34:01 +0000 (UTC)
Message-ID: <0e582a7f5144a33f465978d97701f9b3dcc377f3.camel@perches.com>
Subject: Re: [PATCH] compiler.h: avoid escaped section names
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Sep 2020 11:33:59 -0700
In-Reply-To: <ffe0224b2dc88e091d4d3bb32ee073ffc0585882.camel@perches.com>
References: <20200929194318.548707-1-ndesaulniers@google.com>
         <20200929200801.GA2668747@rani.riverdale.lan>
         <CAKwvOdm=H3GDOPo-dbgsqH7UXzC1twz1h2Rdcidh8OXtFtCY4Q@mail.gmail.com>
         <ffe0224b2dc88e091d4d3bb32ee073ffc0585882.camel@perches.com>
Content-Type: multipart/mixed; boundary="=-aBohwTz58WA21h5mfNas"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--=-aBohwTz58WA21h5mfNas
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Wed, 2020-09-30 at 08:40 -0700, Joe Perches wrote:
> On Tue, 2020-09-29 at 13:25 -0700, Nick Desaulniers wrote:
> > And I don't remember what ever happened to Joe's script for treewide
> > conversion of __section.
> 
> Nor do I but here (attached) is the script.
> 
> My recollection is there was some problem with mscros
> with ## concatenation in some converted uses.

I believe I have it sorted now and I've attached
a new version of the script.

It runs against -next (or any other tree) and
produces a single commit.

It converts all the various uses of
	__attribute__((section(<foo>)))
to
	__section("<foo>")

changes the various macros with token pasting uses
I believe appropriately as well.

Please give it a spin.

There were 4 problems as below.

With these 4 items fixed, the build works (seems to at least)

1:  compiler_attributes.h needed to unquote the __section__(#S)
    the old automated patch didn't apply as the file had changed

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attri>
index ea7b756b1c8f..b6fef9033c0b 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -254,7 +254,7 @@
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#i>
  * clang: https://clang.llvm.org/docs/AttributeReference.html#section-declspec>
  */
-#define __section(S)                    __attribute__((__section__(#S)))
+#define __section(section)              __attribute__((__section__(section)))

2:  The script needed to use different token pasting for
    __section(foo##bar##baz)

    The script converted this to
	__section("foo" ## bar ## "baz")
    instead this needed to be
	__section("foo" #bar "baz")

3:  scripts/mod/modpost.c needed quoting of its internal __section uses:

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 69341b36f271..f882ce0d9327 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2254,7 +2254,7 @@ static void add_header(struct buffer *b, struct module *mod)
        buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
        buf_printf(b, "\n");
        buf_printf(b, "__visible struct module __this_module\n");
-       buf_printf(b, "__section(.gnu.linkonce.this_module) = {\n");
+       buf_printf(b, "__section(\".gnu.linkonce.this_module\") = {\n");
        buf_printf(b, "\t.name = KBUILD_MODNAME,\n");
        if (mod->has_init)
                buf_printf(b, "\t.init = init_module,\n");
@@ -2308,7 +2308,7 @@ static int add_versions(struct buffer *b, struct module *mod)
 
        buf_printf(b, "\n");
        buf_printf(b, "static const struct modversion_info ____versions[]\n");
-       buf_printf(b, "__used __section(__versions) = {\n");
+       buf_printf(b, "__used __section(\"__versions\") = {\n");

4: tools/ was excluded, but now needs conversion

 tools/include/linux/objtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index ab82c793c897..577f51436cf9 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -60,7 +60,7 @@ struct unwind_hint {
  * For more information, see tools/objtool/Documentation/stack-validation.txt.
  */
 #define STACK_FRAME_NON_STANDARD(func) \
-	static void __used __section(.discard.func_stack_frame_non_standard) \
+	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
 #else /* __ASSEMBLY__ */

--=-aBohwTz58WA21h5mfNas
Content-Type: application/x-perl; name="convert_section.pl"
Content-Disposition: attachment; filename="convert_section.pl"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgcGVybAoKIyBjb252ZXJ0IGxpbnV4LWtlcm5lbCBfX3NlY3Rpb24gdXNl
cyBmcm9tIHVucXVvdGVkIHN0cmluZyB0byBxdW90ZWQgc3RyaW5nCiMgY29udmVydCBfX2F0dHJp
YnV0ZV9fKChzZWN0aW9uKCJmb28iKSkpIHRvIF9fc2VjdGlvbigiZm9vIikKIyBjb252ZXJ0IF9f
YXR0cmlidXRlX18oKGZvbywgc2VjdGlvbj0oImJhciIpLCBiYXopKQojICAgICAgdG8gX19zZWN0
aW9uKCJiYXIiKSBhdHRyaWJ1dGUoKGZvbywgYmF6KSkKIyBjb252ZXJ0IF9fYXR0cmlidXRlX18K
CnVzZSBzdHJpY3Q7CgojIHBhdGNoIGNvbXBpbGVyX2F0dHJpYnV0ZXMuaCB0byByZW1vdmUgcXVv
dGluZyBvZiBzZWN0aW9uIG5hbWUKCm15ICRyZXN1bHQgPSBgcGF0Y2ggLXAxIDw8IkVPRiIKIGlu
Y2x1ZGUvbGludXgvY29tcGlsZXJfYXR0cmlidXRlcy5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9jb21waWxlcl9hdHRyaWJ1dGVzLmggYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX2F0dHJpYnV0
ZXMuaAppbmRleCBlYTdiNzU2YjFjOGYuLmIyYTNmNGY2NDFhNyAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9saW51eC9jb21waWxlcl9hdHRyaWJ1dGVzLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxl
cl9hdHRyaWJ1dGVzLmgKQEAgLTI1NCw3ICsyNTQsNyBAQAogICogICBnY2M6IGh0dHBzOi8vZ2Nj
LmdudS5vcmcvb25saW5lZG9jcy9nY2MvQ29tbW9uLVZhcmlhYmxlLUF0dHJpYnV0ZXMuaHRtbCNp
bmRleC1zZWN0aW9uLXZhcmlhYmxlLWF0dHJpYnV0ZQogICogY2xhbmc6IGh0dHBzOi8vY2xhbmcu
bGx2bS5vcmcvZG9jcy9BdHRyaWJ1dGVSZWZlcmVuY2UuaHRtbCNzZWN0aW9uLWRlY2xzcGVjLWFs
bG9jYXRlCiAgKi8KLSNkZWZpbmUgX19zZWN0aW9uKFMpICAgICAgICAgICAgICAgICAgICBfX2F0
dHJpYnV0ZV9fKChfX3NlY3Rpb25fXygjUykpKQorI2RlZmluZSBfX3NlY3Rpb24oc2VjdGlvbikg
ICAgICAgICAgICAgIF9fYXR0cmlidXRlX18oKF9fc2VjdGlvbl9fKHNlY3Rpb24pKSkKIAogLyoK
ICAqICAgZ2NjOiBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjL0NvbW1vbi1GdW5j
dGlvbi1BdHRyaWJ1dGVzLmh0bWwjaW5kZXgtdW51c2VkLWZ1bmN0aW9uLWF0dHJpYnV0ZQpFT0Zg
OwoKIyBwYXRjaCBzY3JpcHRzL21vZC9tb2Rwb3N0LmMgdG8gYWRkIHF1b3Rpbmcgb2Ygc2VjdGlv
biBuYW1lCgpteSAkcmVzdWx0ID0gYHBhdGNoIC1wMSA8PCJFT0YiCiBzY3JpcHRzL21vZC9tb2Rw
b3N0LmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9tb2QvbW9kcG9zdC5jIGIvc2NyaXB0cy9tb2Qv
bW9kcG9zdC5jCmluZGV4IDY5MzQxYjM2ZjI3MS4uZjg4MmNlMGQ5MzI3IDEwMDY0NAotLS0gYS9z
Y3JpcHRzL21vZC9tb2Rwb3N0LmMKKysrIGIvc2NyaXB0cy9tb2QvbW9kcG9zdC5jCkBAIC0yMjU0
LDcgKzIyNTQsNyBAQCBzdGF0aWMgdm9pZCBhZGRfaGVhZGVyKHN0cnVjdCBidWZmZXIgKmIsIHN0
cnVjdCBtb2R1bGUgKm1vZCkKIAlidWZfcHJpbnRmKGIsICJNT0RVTEVfSU5GTyhuYW1lLCBLQlVJ
TERfTU9ETkFNRSk7XFxuIik7CiAJYnVmX3ByaW50ZihiLCAiXFxuIik7CiAJYnVmX3ByaW50Zihi
LCAiX192aXNpYmxlIHN0cnVjdCBtb2R1bGUgX190aGlzX21vZHVsZVxcbiIpOwotCWJ1Zl9wcmlu
dGYoYiwgIl9fc2VjdGlvbiguZ251LmxpbmtvbmNlLnRoaXNfbW9kdWxlKSA9IHtcXG4iKTsKKwli
dWZfcHJpbnRmKGIsICJfX3NlY3Rpb24oXFwiLmdudS5saW5rb25jZS50aGlzX21vZHVsZVxcIikg
PSB7XFxuIik7CiAJYnVmX3ByaW50ZihiLCAiXFx0Lm5hbWUgPSBLQlVJTERfTU9ETkFNRSxcXG4i
KTsKIAlpZiAobW9kLT5oYXNfaW5pdCkKIAkJYnVmX3ByaW50ZihiLCAiXFx0LmluaXQgPSBpbml0
X21vZHVsZSxcXG4iKTsKQEAgLTIzMDgsNyArMjMwOCw3IEBAIHN0YXRpYyBpbnQgYWRkX3ZlcnNp
b25zKHN0cnVjdCBidWZmZXIgKmIsIHN0cnVjdCBtb2R1bGUgKm1vZCkKIAogCWJ1Zl9wcmludGYo
YiwgIlxcbiIpOwogCWJ1Zl9wcmludGYoYiwgInN0YXRpYyBjb25zdCBzdHJ1Y3QgbW9kdmVyc2lv
bl9pbmZvIF9fX192ZXJzaW9uc1tdXFxuIik7Ci0JYnVmX3ByaW50ZihiLCAiX191c2VkIF9fc2Vj
dGlvbihfX3ZlcnNpb25zKSA9IHtcXG4iKTsKKwlidWZfcHJpbnRmKGIsICJfX3VzZWQgX19zZWN0
aW9uKFxcIl9fdmVyc2lvbnNcXCIpID0ge1xcbiIpOwogCiAJZm9yIChzID0gbW9kLT51bnJlczsg
czsgcyA9IHMtPm5leHQpIHsKIAkJaWYgKCFzLT5tb2R1bGUpCkVPRmA7CgojIEdldCB0aGUgbGlz
dCBvZiBmaWxlcyB0byBtb2RpZnkgKGNvbnRhaW5zIF9fc2VjdGlvbiBvciBfX2F0dHJpYnV0ZV9f
LipzZWN0aW9uCiMgKGlnbm9yZSBzY3JpcHRzLCB0b29scywgdWFwaSwgYW5kIGNvbXBpbGVyX2F0
dHJpYnV0ZXMuaCkKCm15ICRvdXRwdXQgPSBgZ2l0IGdyZXAgLS1uYW1lLW9ubHkgLVAgIig/Olxc
Yl9fc2VjdGlvblxcYlx8XFxiX19hdHRyaWJ1dGVfX1xcYi4qc2VjdGlvbikiIHwgZ3JlcCAtdlAg
J14oPzppbmNsdWRlL2xpbnV4L2NvbXBpbGVyX2F0dHJpYnV0ZXNcXC5ofHNjcmlwdHMvfHRvb2xz
L3wvdWFwaS8pJ2A7Cm15IEBmaWxlcyA9IHNwbGl0KCJcbiIsICRvdXRwdXQpOwojIEFkZCB0aGUg
b25seSBmaWxlIGluIHRvb2xzIHRoYXQgbmVlZHMgY29udmVyc2lvbgpwdXNoIChAZmlsZXMsICJ0
b29scy9pbmNsdWRlL2xpbnV4L29ianRvb2wuaCIpOwoKIyBNb2RpZnkgZWFjaCBwb3NzaWJsZSBm
aWxlCmZvcmVhY2ggKEBmaWxlcykgewogICAgY2hvbXA7CiAgICBteSAkZmlsZSA9ICRfOwoKICAg
ICMgcmVhZCB0aGUgb3JpZ2luYWwgZmlsZQogICAgb3BlbihGSCwgJzwnLCAkZmlsZSkgb3IgZGll
ICQhOwogICAgbXkgQGxpbmVzID0gPEZIPjsKICAgIGNsb3NlIEZIOwoKICAgICMgd3JpdGUgdGhl
IG1vZGlmaWVkIGZpbGUgbGluZSBieSBsaW5lCiAgICBvcGVuIChGSCwgJz4nLCAkZmlsZSkgb3Ig
ZGllICQhOwogICAgZm9yZWFjaCBteSAkbGluZSAoQGxpbmVzKSB7CgljaG9tcCAkbGluZTsKCW15
ICRuZXdsaW5lID0gJGxpbmU7CgoJIyBDb252ZXJ0IF9fc2VjdGlvbihmb28pIHRvIF9fc2VjdGlv
bigiZm9vIikKCSMgaWYgImZvbyIgdXNlcyBtdWx0aXBsZSB0b2tlbiBwYXN0aW5nLAoJIyAgIHBy
ZSBhbmQgcG9zdCB0b2tlbnMgcmVtb3ZlZCBhbmQgYSBzaW5nbGUgIyBpcyB1c2VkIHRoZW4gIiAi
IGFkZGVkCgkjICAgZS5nLjogIGZvbyAjIyBiYXIgIyMgYmF6IGJlY29tZXMgImZvbyIgI2JhciAi
YmF6IgoJaWYgKCRsaW5lID1+IG0vXGJfX3NlY3Rpb25ccypcKFxzKig/ISIpKFteXCldKylcKS8p
IHsKCSAgICBteSAkb2xkc2VjdGlvbiA9ICQxOwoJICAgIG15ICRuZXdzZWN0aW9uID0gJDE7Cgkg
ICAgaWYgKCRvbGRzZWN0aW9uID1+IC8oLiopIyMoLiopIyMoLiopLykgewoJCSRuZXdzZWN0aW9u
ID0gJyInIC4gdHJpbSgkMSkgLiAnIiAjJyAuIHRyaW0oJDIpIC4gJyAiJyAuIHRyaW0oJDMpIC4g
JyInOwoJICAgIH0gZWxzZSB7CgkJJG5ld3NlY3Rpb24gPSAnIicgLiB0cmltKCRvbGRzZWN0aW9u
KSAuICciJzsKCSAgICB9CgkgICAgJG5ld2xpbmUgPX4gcy9fX3NlY3Rpb25ccypcKFxzKlxRJG9s
ZHNlY3Rpb25cRVxzKlwpL19fc2VjdGlvbigkbmV3c2VjdGlvbikvOwoJfQoKCSMgY29udmVydCBf
X2F0dHJpYnV0ZV9fKChzZWN0aW9uKCJmb28iKSkpIHRvIF9fc2VjdGlvbigiZm9vIikKCSRuZXds
aW5lID1+IHMvXGJfX2F0dHJpYnV0ZV9fXHMqXChccypcKFxzKl8qc2VjdGlvbl8qXHMqXChccyoo
IlteIl0rIilccypcKVxzKlwpXHMqXCkvX19zZWN0aW9uKCQxKS87CgoJIyBjb252ZXJ0IF9fYXR0
cmlidXRlX18oKGZvbywgc2VjdGlvbj0oImJhciIpLCBiYXopKQoJIyB0byBfX3NlY3Rpb24oImJh
ciIpIGF0dHJpYnV0ZSgoZm9vLCBiYXopKQoJaWYgKCRuZXdsaW5lID1+IC8oXGJfX2F0dHJpYnV0
ZV9fXHMqXChccypcKChbXixfXSspPyhccyosP1xzKl8qc2VjdGlvbl8qXHMqXChccyooIlteIl0r
IilccypcKVxzKiw/XHMqKSguKilccypcKVxzKlwpKS8pIHsKCSAgICBteSAkc2VjdGlvbiA9ICQz
OwoJICAgIG15ICRjb21tYSA9ICIiOwoJICAgICRjb21tYSA9ICIsICIgaWYgKCRzZWN0aW9uID1+
IC9eXHMqLC8gJiYgJHNlY3Rpb24gPX4gLyxccyokLyk7CgkgICAgJG5ld2xpbmUgPX4gcy9cUSRz
ZWN0aW9uXEUvJGNvbW1hLzsKCSAgICAkc2VjdGlvbiA9fiBzL15bXiJdKi8vOwoJICAgICRzZWN0
aW9uID1+IHMvXigiW14iXSoiKS4qLyQxLzsKCSAgICAkbmV3bGluZSA9fiBzL1xiX19hdHRyaWJ1
dGVfXy9fX3NlY3Rpb24oJHNlY3Rpb24pIF9fYXR0cmlidXRlX18vOwoJfQoKCSMgaWYgdGhlIGxp
bmUgZW5kZWQgd2l0aCBhIGxpbmUgY29udGludWF0aW9uIFwsIHRyeSB0byBtb3ZlIHRoZQoJIyBj
b250aW51YXRpb24gdG8gdGhlIHNhbWUgbG9jYXRpb24gYnkgcmVtb3Zpbmcgb3IgYWRkaW5nIHRh
YnMKCWlmICgkbGluZSA9fiAvXFwkLykgewoJICAgIG15ICRvbGVuID0gbGVuZ3RoKGV4cGFuZF90
YWJzKCRsaW5lKSk7CgkgICAgbXkgJG5sZW4gPSBsZW5ndGgoZXhwYW5kX3RhYnMoJG5ld2xpbmUp
KTsKCSAgICBpZiAoJG5ld2xpbmUgPX4gL1x0XFwkLykgewoJCWlmICgkbmxlbiA+ICRvbGVuKSB7
CgkJICAgICRuZXdsaW5lID1+IHMvXHRcXCQvXFwvOwoJCX0gZWxzZSB7CgkJICAgIHdoaWxlICgk
bmxlbiA8ICRvbGVuKSB7CgkJCSRuZXdsaW5lID1+IHMvXFwkL1x0XFwvOwoJCQkkbmxlbiA9IGxl
bmd0aChleHBhbmRfdGFicygkbmV3bGluZSkpOwoJCSAgICB9CgkJfQoJICAgIH0KCX0KCXByaW50
IEZIICIkbmV3bGluZVxuIjsKICAgIH0KICAgIGNsb3NlIEZIOwp9CgojIEFuZCBnaXQgY29tbWl0
IHRoZSBjaGFuZ2VzCiRyZXN1bHQgPSBxeHtnaXQgY29tbWl0IC1hIC0tYXV0aG9yPSdKb2UgUGVy
Y2hlcyA8am9lXEBwZXJjaGVzLmNvbT4nIC1GLSA8PCJFT0YiCnRyZWV3aWRlOiBDb252ZXJ0IG1h
Y3JvIGFuZCB1c2VzIG9mIF9fc2VjdGlvbihmb28pIHRvIF9fc2VjdGlvbigiZm9vIikKClVzZSBh
IG1vcmUgZ2VuZXJpYyBmb3JtIGZvciBfX3NlY3Rpb24gdGhhdCByZXF1aXJlcyBxdW90ZXMgdG8g
YXZvaWQKY29tcGxpY2F0aW9ucyB3aXRoIGNsYW5nIGFuZCBnY2MgZGlmZmVyZW5jZXMuCgpSZW1v
dmUgdGhlIHF1b3RlIG9wZXJhdG9yICMgZnJvbSBjb21waWxlcl9hdHRyaWJ1dGVzLmggX19zZWN0
aW9uIG1hY3JvLgoKQ29udmVydCBhbGwgdW5xdW90ZWQgX19zZWN0aW9uKGZvbykgdXNlcyB0byBx
dW90ZWQgX19zZWN0aW9uKCJmb28iKS4KQWxzbyBjb252ZXJ0IF9fYXR0cmlidXRlX18oKHNlY3Rp
b24oImZvbyIpKSkgdXNlcyB0byBfX3NlY3Rpb24oImZvbyIpCmV2ZW4gaWYgdGhlIF9fYXR0cmli
dXRlX18gaGFzIG11bHRpcGxlIGxpc3QgZW50cnkgZm9ybXMuCgpTaWduZWQtb2ZmLWJ5OiBKb2Ug
UGVyY2hlcyA8am9lXEBwZXJjaGVzLmNvbT4KRU9GCn07CgojIHV0aWxpdHkgc3Vicm91dGluZXMK
c3ViIHRyaW0gewogICAgbXkgKCRzdHJpbmcpID0gQF87CiAgICAkc3RyaW5nID1+IHMvXlxzK3xc
cyskLy9nOwogICAgcmV0dXJuICRzdHJpbmc7Cn0KCnN1YiBleHBhbmRfdGFicyB7CiAgICBteSAo
JHN0cikgPSBAXzsKCiAgICBteSAkcmVzID0gJyc7CiAgICBteSAkbiA9IDA7CiAgICBmb3IgbXkg
JGMgKHNwbGl0KC8vLCAkc3RyKSkgewoJaWYgKCRjIGVxICJcdCIpIHsKCSAgICAkcmVzIC49ICcg
JzsKCSAgICAkbisrOwoJICAgIGZvciAoOyAoJG4gJSA4KSAhPSAwOyAkbisrKSB7CgkJJHJlcyAu
PSAnICc7CgkgICAgfQoJICAgIG5leHQ7Cgl9CgkkcmVzIC49ICRjOwoJJG4rKzsKICAgIH0KCiAg
ICByZXR1cm4gJHJlczsKfQo=


--=-aBohwTz58WA21h5mfNas--

