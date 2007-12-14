From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Re: [PATCH 15/16] deal with enum members without excessive PITA
Date: Fri, 14 Dec 2007 13:01:03 -0800
Message-ID: <70318cbf0712141301s7bafda84ta7d7b087a0f13685@mail.gmail.com>
References: <70318cbf0712131618k6b3ffc98ibbf68156dc67b52e@mail.gmail.com>
	 <OF6BBF04CB.C9CFEDC1-ONC12573B1.003FBE96-C12573B1.0042C7E1@br-automation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2312_23891321.1197666063318"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:57729 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694AbXLNVBE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 14 Dec 2007 16:01:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1057690rvb.1
        for <linux-sparse@vger.kernel.org>; Fri, 14 Dec 2007 13:01:03 -0800 (PST)
In-Reply-To: <OF6BBF04CB.C9CFEDC1-ONC12573B1.003FBE96-C12573B1.0042C7E1@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

------=_Part_2312_23891321.1197666063318
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 14, 2007 4:09 AM, Thomas Schmid <Thomas.Schmid@br-automation.com> wrote:
> How about the idea, looping over the syms within global_scope?

I think that will work too.

> > > It should be trivial make a patch to add members to the parent
> > symbol->symbol_list though.
> Would you possibly?

Can you try the attached patch?

Chris

------=_Part_2312_23891321.1197666063318
Content-Type: application/octet-stream; name=enum-members
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fa77eyb80
Content-Disposition: attachment; filename=enum-members

QWRkIGVudW0gbWVtYmVyIGxpc3QgdG8gdGhlIHBhcmVudAoKU2lnbmVkLU9mZi1CeTogQ2hyaXN0
b3BoZXIgTGkgPHNwYXJzZUBjaHJpc2xpLm9yZz4KCkluZGV4OiBzcGFyc2UvcGFyc2UuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBzcGFyc2Uub3JpZy9wYXJzZS5jCTIwMDctMTItMTQgMTI6MzM6MDUuMDAwMDAw
MDAwIC0wODAwCisrKyBzcGFyc2UvcGFyc2UuYwkyMDA3LTEyLTE0IDEyOjQyOjM5LjAwMDAwMDAw
MCAtMDgwMApAQCAtNjUxLDcgKzY1MSw2IEBAIHN0YXRpYyBzdHJ1Y3QgdG9rZW4gKnBhcnNlX2Vu
dW1fZGVjbGFyYXQKIAl1bnNpZ25lZCBsb25nIGxvbmcgbGFzdHZhbCA9IDA7CiAJc3RydWN0IHN5
bWJvbCAqY3R5cGUgPSBOVUxMLCAqYmFzZV90eXBlID0gTlVMTDsKIAlOdW0gdXBwZXIgPSB7LTEs
IDB9LCBsb3dlciA9IHsxLCAwfTsKLQlzdHJ1Y3Qgc3ltYm9sX2xpc3QgKmVudHJpZXMgPSBOVUxM
OwogCiAJcGFyZW50LT5leGFtaW5lZCA9IDE7CiAJcGFyZW50LT5jdHlwZS5iYXNlX3R5cGUgPSAm
aW50X2N0eXBlOwpAQCAtNjg3LDcgKzY4Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgdG9rZW4gKnBhcnNl
X2VudW1fZGVjbGFyYXQKIAkJc3ltLT5pbml0aWFsaXplciA9IGV4cHI7CiAJCXN5bS0+ZW51bV9t
ZW1iZXIgPSAxOwogCQlzeW0tPmN0eXBlLmJhc2VfdHlwZSA9IHBhcmVudDsKLQkJYWRkX3B0cl9s
aXN0KCZlbnRyaWVzLCBzeW0pOworCQlhZGRfcHRyX2xpc3QoJnBhcmVudC0+c3ltYm9sX2xpc3Qs
IHN5bSk7CiAKIAkJaWYgKGJhc2VfdHlwZSAhPSAmYmFkX2N0eXBlKSB7CiAJCQlpZiAoY3R5cGUt
PnR5cGUgPT0gU1lNX05PREUpCkBAIC03NjMsOCArNzYyLDcgQEAgc3RhdGljIHN0cnVjdCB0b2tl
biAqcGFyc2VfZW51bV9kZWNsYXJhdAogCXBhcmVudC0+Y3R5cGUubW9kaWZpZXJzIHw9IChiYXNl
X3R5cGUtPmN0eXBlLm1vZGlmaWVycyAmIE1PRF9VTlNJR05FRCk7CiAJcGFyZW50LT5leGFtaW5l
ZCA9IDA7CiAKLQljYXN0X2VudW1fbGlzdChlbnRyaWVzLCBiYXNlX3R5cGUpOwotCWZyZWVfcHRy
X2xpc3QoJmVudHJpZXMpOworCWNhc3RfZW51bV9saXN0KHBhcmVudC0+c3ltYm9sX2xpc3QsIGJh
c2VfdHlwZSk7CiAKIAlyZXR1cm4gdG9rZW47CiB9Cg==
------=_Part_2312_23891321.1197666063318--
