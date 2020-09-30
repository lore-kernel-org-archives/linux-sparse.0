Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED29C4727C
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 15:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E81B20738
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 15:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgI3Pp6 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:45:58 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:39854 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729940AbgI3Pp6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 11:45:58 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 11:45:57 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 5B7521801D1FB
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 15:40:16 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E525F18225E14;
        Wed, 30 Sep 2020 15:40:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shirt16_0b14cd527194
X-Filterd-Recvd-Size: 8925
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 15:40:12 +0000 (UTC)
Message-ID: <ffe0224b2dc88e091d4d3bb32ee073ffc0585882.camel@perches.com>
Subject: Re: [PATCH] compiler.h: avoid escaped section names
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Wed, 30 Sep 2020 08:40:11 -0700
In-Reply-To: <CAKwvOdm=H3GDOPo-dbgsqH7UXzC1twz1h2Rdcidh8OXtFtCY4Q@mail.gmail.com>
References: <20200929194318.548707-1-ndesaulniers@google.com>
         <20200929200801.GA2668747@rani.riverdale.lan>
         <CAKwvOdm=H3GDOPo-dbgsqH7UXzC1twz1h2Rdcidh8OXtFtCY4Q@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-b2mXhRFB+I/U/qMewy+F"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--=-b2mXhRFB+I/U/qMewy+F
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Tue, 2020-09-29 at 13:25 -0700, Nick Desaulniers wrote:
> And I don't remember what ever happened to Joe's script for treewide
> conversion of __section.

Nor do I but here (attached) is the script.

My recollection is there was some problem with mscros
with ## concatenation in some converted uses.


--=-b2mXhRFB+I/U/qMewy+F
Content-Type: application/x-perl; name="convert_section.pl"
Content-Disposition: attachment; filename="convert_section.pl"
Content-Transfer-Encoding: base64

IyBjb252ZXJ0IGxpbnV4LWtlcm5lbCBfX3NlY3Rpb24gdXNlcyBmcm9tIHVucXVvdGVkIHN0cmlu
ZyB0byBxdW90ZWQgc3RyaW5nCiMgY29udmVydCBfX2F0dHJpYnV0ZV9fKChzZWN0aW9uKCJmb28i
KSkpIHRvIF9fc2VjdGlvbigiZm9vIikKIyBjb252ZXJ0IF9fYXR0cmlidXRlX18oKGZvbywgc2Vj
dGlvbj0oImJhciIpLCBiYXopKQojICAgICAgdG8gX19zZWN0aW9uKCJiYXIiKSBhdHRyaWJ1dGUo
KGZvbywgYmF6KSkKIyBjb252ZXJ0IF9fYXR0cmlidXRlX18KCnVzZSBzdHJpY3Q7CgojIHBhdGNo
IGNvbXBpbGVyX2F0dHJpYnV0ZXMuaCB0byByZW1vdmUgcXVvdGluZyBvZiBzZWN0aW9uIG5hbWUK
Cm15ICRyZXN1bHQgPSBxeHtwYXRjaCAtcDEgPDwiRU9GIgogaW5jbHVkZS9saW51eC9jb21waWxl
cl9hdHRyaWJ1dGVzLmggfCAxMiArLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jb21w
aWxlcl9hdHRyaWJ1dGVzLmggYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX2F0dHJpYnV0ZXMuaApp
bmRleCA5Y2EwNDBmYTFjYzYuLjg4ZDNlZWExY2JiYSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9jb21waWxlcl9hdHRyaWJ1dGVzLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlcl9hdHRy
aWJ1dGVzLmgKQEAgLTIyNSwyMSArMjI1LDExIEBACiAjZGVmaW5lIF9fcHVyZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgX19hdHRyaWJ1dGVfXygoX19wdXJlX18pKQogCiAvKgotICogTm90ZTog
U2luY2UgdGhpcyBtYWNybyBtYWtlcyB1c2Ugb2YgdGhlICJzdHJpbmdpZmljYXRpb24gb3BlcmF0
b3IiIGAjYCwKLSAqIGEgcXVvdGVkIHN0cmluZyBsaXRlcmFsIHNob3VsZCBub3QgYmUgcGFzc2Vk
IHRvIGl0LiBlZy4gcHJlZmVyOgotICogICAgIF9fc2VjdGlvbiguZm9vKQotICogdG86Ci0gKiAg
ICAgX19zZWN0aW9uKCIuZm9vIikKLSAqIHVubGVzcyB0aGUgc2VjdGlvbiBuYW1lIGlzIGR5bmFt
aWNhbGx5IGJ1aWx0IHVwLCBpbiB3aGljaCBjYXNlIHRoZQotICogdmVyYm9zZSBfX2F0dHJpYnV0
ZV9fKChfX3NlY3Rpb25fXygiLmZvbyIgeCkpKSBzaG91bGQgYmUgcHJlZmVycmVkLgotICoKLSAq
IFNlZSBhbHNvOiBodHRwczovL2J1Z3MubGx2bS5vcmcvc2hvd19idWcuY2dpP2lkPTQyOTUwCi0g
KgogICogICBnY2M6IGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvQ29tbW9uLUZ1
bmN0aW9uLUF0dHJpYnV0ZXMuaHRtbCNpbmRleC1zZWN0aW9uLWZ1bmN0aW9uLWF0dHJpYnV0ZQog
ICogICBnY2M6IGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvQ29tbW9uLVZhcmlh
YmxlLUF0dHJpYnV0ZXMuaHRtbCNpbmRleC1zZWN0aW9uLXZhcmlhYmxlLWF0dHJpYnV0ZQogICog
Y2xhbmc6IGh0dHBzOi8vY2xhbmcubGx2bS5vcmcvZG9jcy9BdHRyaWJ1dGVSZWZlcmVuY2UuaHRt
bCNzZWN0aW9uLWRlY2xzcGVjLWFsbG9jYXRlCiAgKi8KLSNkZWZpbmUgX19zZWN0aW9uKFMpICAg
ICAgICAgICAgICAgICAgICBfX2F0dHJpYnV0ZV9fKChfX3NlY3Rpb25fXygjUykpKQorI2RlZmlu
ZSBfX3NlY3Rpb24oc2VjdGlvbikgICAgICAgICAgICAgIF9fYXR0cmlidXRlX18oKF9fc2VjdGlv
bl9fKHNlY3Rpb24pKSkKIAogLyoKICAqICAgZ2NjOiBodHRwczovL2djYy5nbnUub3JnL29ubGlu
ZWRvY3MvZ2NjL0NvbW1vbi1GdW5jdGlvbi1BdHRyaWJ1dGVzLmh0bWwjaW5kZXgtdW51c2VkLWZ1
bmN0aW9uLWF0dHJpYnV0ZQpFT0Z9OwoKIyBHZXQgdGhlIGxpc3Qgb2YgZmlsZXMgdG8gbW9kaWZ5
IChjb250YWlucyBfX3NlY3Rpb24gb3IgX19hdHRyaWJ1dGVfXy4qc2VjdGlvbgojIChpZ25vcmUg
c2NyaXB0cywgdG9vbHMsIHVhcGksIGFuZCBjb21waWxlcl9hdHRyaWJ1dGVzLmgpCgpteSAkb3V0
cHV0ID0gYGdpdCBncmVwIC0tbmFtZS1vbmx5IC1QICIoPzpcXGJfX3NlY3Rpb25cXGJcfFxcYl9f
YXR0cmlidXRlX19cXGIuKnNlY3Rpb24pIiB8IGdyZXAgLXZQICdeKD86aW5jbHVkZS9saW51eC9j
b21waWxlcl9hdHRyaWJ1dGVzXFwuaHxzY3JpcHRzL3x0b29scy98L3VhcGkvKSdgOwpteSBAZmls
ZXMgPSBzcGxpdCgiXG4iLCAkb3V0cHV0KTsKCiMgTW9kaWZ5IGVhY2ggcG9zc2libGUgZmlsZQpm
b3JlYWNoIChAZmlsZXMpIHsKICAgIGNob21wOwogICAgbXkgJGZpbGUgPSAkXzsKCiAgICAjIHJl
YWQgdGhlIG9yaWdpbmFsIGZpbGUKICAgIG9wZW4oRkgsICc8JywgJGZpbGUpIG9yIGRpZSAkITsK
ICAgIG15IEBsaW5lcyA9IDxGSD47CiAgICBjbG9zZSBGSDsKCiAgICAjIHdyaXRlIHRoZSBtb2Rp
ZmllZCBmaWxlIGxpbmUgYnkgbGluZQogICAgb3BlbiAoRkgsICc+JywgJGZpbGUpIG9yIGRpZSAk
ITsKICAgIGZvcmVhY2ggbXkgJGxpbmUgKEBsaW5lcykgewoJY2hvbXAgJGxpbmU7CglteSAkbmV3
bGluZSA9ICRsaW5lOwoKCSMgQ29udmVydCBfX3NlY3Rpb24oZm9vKSB0byBfX3NlY3Rpb24oImZv
byIpCgkjIGlmICJmb28iIHVzZXMgdG9rZW4gcGFzdGluZywgcHJlIGFuZCBwb3N0IHRva2VucyBh
cmUgYWxzbyBxdW90ZWQKCWlmICgkbGluZSA9fiBtL1xiX19zZWN0aW9uXHMqXChccyooPyEiKShb
XlwpXSspXCkvKSB7CgkgICAgbXkgJG9sZHNlY3Rpb24gPSAkMTsKCSAgICBteSAkbmV3c2VjdGlv
biA9ICQxOwoJICAgIGlmICgkb2xkc2VjdGlvbiA9fiAvKC4qKSMjKC4qKSMjKC4qKS8pIHsKCQkk
bmV3c2VjdGlvbiA9ICciJyAuIHRyaW0oJDEpIC4gJyIgIyMgJyAuIHRyaW0oJDIpIC4gJyAjIyAi
JyAuIHRyaW0oJDMpIC4gJyInOwoJICAgIH0gZWxzZSB7CgkJJG5ld3NlY3Rpb24gPSAnIicgLiB0
cmltKCRvbGRzZWN0aW9uKSAuICciJzsKCSAgICB9CgkgICAgJG5ld2xpbmUgPX4gcy9fX3NlY3Rp
b25ccypcKFxzKlxRJG9sZHNlY3Rpb25cRVxzKlwpL19fc2VjdGlvbigkbmV3c2VjdGlvbikvOwoJ
fQoKCSMgY29udmVydCBfX2F0dHJpYnV0ZV9fKChzZWN0aW9uKCJmb28iKSkpIHRvIF9fc2VjdGlv
bigiZm9vIikKCSRuZXdsaW5lID1+IHMvXGJfX2F0dHJpYnV0ZV9fXHMqXChccypcKFxzKl8qc2Vj
dGlvbl8qXHMqXChccyooIlteIl0rIilccypcKVxzKlwpXHMqXCkvX19zZWN0aW9uKCQxKS87CgoJ
IyBjb252ZXJ0IF9fYXR0cmlidXRlX18oKGZvbywgc2VjdGlvbj0oImJhciIpLCBiYXopKQoJIyB0
byBfX3NlY3Rpb24oImJhciIpIGF0dHJpYnV0ZSgoZm9vLCBiYXopKQoJaWYgKCRuZXdsaW5lID1+
IC8oXGJfX2F0dHJpYnV0ZV9fXHMqXChccypcKChbXixfXSspPyhccyosP1xzKl8qc2VjdGlvbl8q
XHMqXChccyooIlteIl0rIilccypcKVxzKiw/XHMqKSguKilccypcKVxzKlwpKS8pIHsKCSAgICBt
eSAkc2VjdGlvbiA9ICQzOwoJICAgIG15ICRjb21tYSA9ICIiOwoJICAgICRjb21tYSA9ICIsICIg
aWYgKCRzZWN0aW9uID1+IC9eXHMqLC8gJiYgJHNlY3Rpb24gPX4gLyxccyokLyk7CgkgICAgJG5l
d2xpbmUgPX4gcy9cUSRzZWN0aW9uXEUvJGNvbW1hLzsKCSAgICAkc2VjdGlvbiA9fiBzL15bXiJd
Ki8vOwoJICAgICRzZWN0aW9uID1+IHMvXigiW14iXSoiKS4qLyQxLzsKCSAgICAkbmV3bGluZSA9
fiBzL1xiX19hdHRyaWJ1dGVfXy9fX3NlY3Rpb24oJHNlY3Rpb24pIF9fYXR0cmlidXRlX18vOwoJ
fQoKCSMgaWYgdGhlIGxpbmUgZW5kZWQgd2l0aCBhIGxpbmUgY29udGludWF0aW9uIFwsIHRyeSB0
byBtb3ZlIHRoZQoJIyBjb250aW51YXRpb24gdG8gdGhlIHNhbWUgbG9jYXRpb24gYnkgcmVtb3Zp
bmcgb3IgYWRkaW5nIHRhYnMKCWlmICgkbGluZSA9fiAvXFwkLykgewoJICAgIG15ICRvbGVuID0g
bGVuZ3RoKGV4cGFuZF90YWJzKCRsaW5lKSk7CgkgICAgbXkgJG5sZW4gPSBsZW5ndGgoZXhwYW5k
X3RhYnMoJG5ld2xpbmUpKTsKCSAgICBpZiAoJG5ld2xpbmUgPX4gL1x0XFwkLykgewoJCWlmICgk
bmxlbiA+ICRvbGVuKSB7CgkJICAgICRuZXdsaW5lID1+IHMvXHRcXCQvXFwvOwoJCX0gZWxzZSB7
CgkJICAgIHdoaWxlICgkbmxlbiA8ICRvbGVuKSB7CgkJCSRuZXdsaW5lID1+IHMvXFwkL1x0XFwv
OwoJCQkkbmxlbiA9IGxlbmd0aChleHBhbmRfdGFicygkbmV3bGluZSkpOwoJCSAgICB9CgkJfQoJ
ICAgIH0KCX0KCXByaW50IEZIICIkbmV3bGluZVxuIjsKICAgIH0KICAgIGNsb3NlIEZIOwp9Cgoj
IEFuZCBnaXQgY29tbWl0IHRoZSBjaGFuZ2VzCiRyZXN1bHQgPSBxeHtnaXQgY29tbWl0IC1hIC0t
YXV0aG9yPSdKb2UgUGVyY2hlcyA8am9lXEBwZXJjaGVzLmNvbT4nIC1GLSA8PCJFT0YiCnRyZWV3
aWRlOiBDb252ZXJ0IG1hY3JvIGFuZCB1c2VzIG9mIF9fc2VjdGlvbihmb28pIHRvIF9fc2VjdGlv
bigiZm9vIikKClVzZSBhIG1vcmUgZ2VuZXJpYyBmb3JtIGZvciBfX3NlY3Rpb24gdGhhdCByZXF1
aXJlcyBxdW90ZXMgdG8gYXZvaWQKY29tcGxpY2F0aW9ucyB3aXRoIGNsYW5nIGFuZCBnY2MgZGlm
ZmVyZW5jZXMuCgpSZW1vdmUgdGhlIHF1b3RlIG9wZXJhdG9yICMgZnJvbSBjb21waWxlcl9hdHRy
aWJ1dGVzLmggX19zZWN0aW9uIG1hY3JvLgoKQ29udmVydCBhbGwgdW5xdW90ZWQgX19zZWN0aW9u
KGZvbykgdXNlcyB0byBxdW90ZWQgX19zZWN0aW9uKCJmb28iKS4KQWxzbyBjb252ZXJ0IF9fYXR0
cmlidXRlX18oKHNlY3Rpb24oImZvbyIpKSkgdXNlcyB0byBfX3NlY3Rpb24oImZvbyIpCmV2ZW4g
aWYgdGhlIF9fYXR0cmlidXRlX18gaGFzIG11bHRpcGxlIGxpc3QgZW50cnkgZm9ybXMuCgpTaWdu
ZWQtb2ZmLWJ5OiBKb2UgUGVyY2hlcyA8am9lXEBwZXJjaGVzLmNvbT4KRU9GCn07CgojIHV0aWxp
dHkgc3Vicm91dGluZXMKc3ViIHRyaW0gewogICAgbXkgKCRzdHJpbmcpID0gQF87CiAgICAkc3Ry
aW5nID1+IHMvXlxzK3xccyskLy9nOwogICAgcmV0dXJuICRzdHJpbmc7Cn0KCnN1YiBleHBhbmRf
dGFicyB7CiAgICBteSAoJHN0cikgPSBAXzsKCiAgICBteSAkcmVzID0gJyc7CiAgICBteSAkbiA9
IDA7CiAgICBmb3IgbXkgJGMgKHNwbGl0KC8vLCAkc3RyKSkgewoJaWYgKCRjIGVxICJcdCIpIHsK
CSAgICAkcmVzIC49ICcgJzsKCSAgICAkbisrOwoJICAgIGZvciAoOyAoJG4gJSA4KSAhPSAwOyAk
bisrKSB7CgkJJHJlcyAuPSAnICc7CgkgICAgfQoJICAgIG5leHQ7Cgl9CgkkcmVzIC49ICRjOwoJ
JG4rKzsKICAgIH0KCiAgICByZXR1cm4gJHJlczsKfQo=


--=-b2mXhRFB+I/U/qMewy+F--

