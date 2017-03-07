From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 06/13] llvm: fix type of literal integer passed as arguments
Date: Tue, 7 Mar 2017 23:33:19 +0800
Message-ID: <CANeU7Qnoqg-rM2MS+3BuKEvsLUBvnv+rvfYmE=XkhMicdejN=A@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com> <20170305112047.3411-7-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1141976244884f054a25bb07
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37902 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755572AbdCGQDS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 11:03:18 -0500
Received: by mail-it0-f49.google.com with SMTP id m27so7184583iti.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Mar 2017 08:03:17 -0800 (PST)
In-Reply-To: <20170305112047.3411-7-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

--001a1141976244884f054a25bb07
Content-Type: text/plain; charset=UTF-8

On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Like for all others instructions, LLVM needs the type
> of each operands. However this information is not always
> available via the pseudo, like here when passing a integer
> constant as argument since for sparse constants are typeless.
>
> Fix this by getting the type via the function prototype.
>
> +               LLVMValueRef value;
> +               if (arg->type == PSEUDO_VAL) {
> +                       /* Value pseudos do not have type information. */
> +                       /* Use the function prototype to get the type. */
> +                       struct symbol *ctype = get_nth1_arg(insn->func->sym, i + 1);

I try to come up with an example to use the PREPARE_PTR_LIST() in this patch.
I hit a bug "insn->func->sym"  assume "insn->func" is a function symbol node.
If "insn->func" is a function pointer then access "insn->func->sym" is wrong.

Any way, my modify patch attached. It should work similar to this patch
without using the nth argument help function. My limited test hit this
function pointer bug.


Chris

--001a1141976244884f054a25bb07
Content-Type: text/x-patch; charset=US-ASCII;
	name="9604557-06-13-llvm-fix-type-of-literal-integer-passed-as-arguments-1.patch"
Content-Disposition: attachment;
	filename="9604557-06-13-llvm-fix-type-of-literal-integer-passed-as-arguments-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_izzp0p6o0

RnJvbSBwYXRjaHdvcmsgU3VuIE1hciAgNSAxMToyMDo0MCAyMDE3CkNvbnRlbnQtVHlwZTogdGV4
dC9wbGFpbjsgY2hhcnNldD0idXRmLTgiCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDdiaXQKU3ViamVjdDogWzA2LzEzXSBsbHZtOiBmaXggdHlwZSBvZiBsaXRl
cmFsIGludGVnZXIgcGFzc2VkIGFzIGFyZ3VtZW50cwpGcm9tOiBMdWMgVmFuIE9vc3RlbnJ5Y2sg
PGx1Yy52YW5vb3N0ZW5yeWNrQGdtYWlsLmNvbT4KWC1QYXRjaHdvcmstSWQ6IDk2MDQ1NTcKTWVz
c2FnZS1JZDogPDIwMTcwMzA1MTEyMDQ3LjM0MTEtNy1sdWMudmFub29zdGVucnlja0BnbWFpbC5j
b20+ClRvOiBsaW51eC1zcGFyc2VAdmdlci5rZXJuZWwub3JnCkNjOiBEaWJ5ZW5kdSBNYWp1bWRh
ciA8bW9iaWxlQG1hanVtZGFyLm9yZy51az4sCiBMdWMgVmFuIE9vc3RlbnJ5Y2sgPGx1Yy52YW5v
b3N0ZW5yeWNrQGdtYWlsLmNvbT4KRGF0ZTogU3VuLCAgNSBNYXIgMjAxNyAxMjoyMDo0MCArMDEw
MAoKTGlrZSBmb3IgYWxsIG90aGVycyBpbnN0cnVjdGlvbnMsIExMVk0gbmVlZHMgdGhlIHR5cGUK
b2YgZWFjaCBvcGVyYW5kcy4gSG93ZXZlciB0aGlzIGluZm9ybWF0aW9uIGlzIG5vdCBhbHdheXMK
YXZhaWxhYmxlIHZpYSB0aGUgcHNldWRvLCBsaWtlIGhlcmUgd2hlbiBwYXNzaW5nIGEgaW50ZWdl
cgpjb25zdGFudCBhcyBhcmd1bWVudCBzaW5jZSBmb3Igc3BhcnNlIGNvbnN0YW50cyBhcmUgdHlw
ZWxlc3MuCgpGaXggdGhpcyBieSBnZXR0aW5nIHRoZSB0eXBlIHZpYSB0aGUgZnVuY3Rpb24gcHJv
dG90eXBlLgoKUmVwb3J0ZWQtYnk6IERpYnllbmR1IE1hanVtZGFyIDxtb2JpbGVAbWFqdW1kYXIu
b3JnLnVrPgpTaWduZWQtb2ZmLWJ5OiBMdWMgVmFuIE9vc3RlbnJ5Y2sgPGx1Yy52YW5vb3N0ZW5y
eWNrQGdtYWlsLmNvbT4KLS0tCiBzcGFyc2UtbGx2bS5jIHwgMTEgKysrKysrKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgoKCi0tLSBzcGFyc2Uu
Y2hyaXNsLm9yaWcvc3BhcnNlLWxsdm0uYworKysgc3BhcnNlLmNocmlzbC9zcGFyc2UtbGx2bS5j
CkBAIC03MjksNiArNzI5LDggQEAgc3RhdGljIHZvaWQgb3V0cHV0X29wX2NhbGwoc3RydWN0IGZ1
bmN0aQogewogCUxMVk1WYWx1ZVJlZiB0YXJnZXQsIGZ1bmM7CiAJaW50IG5fYXJnID0gMCwgaTsK
KwlzdHJ1Y3Qgc3ltYm9sX2xpc3QgKmFyZ3VtZW50X3R5cGVzID0gaW5zbi0+ZnVuYy0+c3ltLT5j
dHlwZS5iYXNlX3R5cGUtPmFyZ3VtZW50czsKKwlzdHJ1Y3Qgc3ltYm9sICphcmd0eXBlOwogCXN0
cnVjdCBwc2V1ZG8gKmFyZzsKIAlMTFZNVmFsdWVSZWYgKmFyZ3M7CiAKQEAgLTczOSw5ICs3NDEs
MjAgQEAgc3RhdGljIHZvaWQgb3V0cHV0X29wX2NhbGwoc3RydWN0IGZ1bmN0aQogCWFyZ3MgPSBj
YWxsb2Mobl9hcmcsIHNpemVvZihMTFZNVmFsdWVSZWYpKTsKIAogCWkgPSAwOworCVBSRVBBUkVf
UFRSX0xJU1QoYXJndW1lbnRfdHlwZXMsIGFyZ3R5cGUpOwogCUZPUl9FQUNIX1BUUihpbnNuLT5h
cmd1bWVudHMsIGFyZykgewotCQlhcmdzW2krK10gPSBwc2V1ZG9fdG9fdmFsdWUoZm4sIGluc24s
IGFyZyk7CisJCUxMVk1WYWx1ZVJlZiB2YWx1ZTsKKwkJaWYgKGFyZy0+dHlwZSA9PSBQU0VVRE9f
VkFMKSB7CisJCQkvKiBWYWx1ZSBwc2V1ZG9zIGRvIG5vdCBoYXZlIHR5cGUgaW5mb3JtYXRpb24u
ICovCisJCQkvKiBVc2UgdGhlIGZ1bmN0aW9uIHByb3RvdHlwZSB0byBnZXQgdGhlIHR5cGUuICov
CisJCQl2YWx1ZSA9IHZhbF90b192YWx1ZShmbiwgYXJnLT52YWx1ZSwgYXJndHlwZSk7CisJCX0g
ZWxzZSB7CisJCQl2YWx1ZSA9IHBzZXVkb190b192YWx1ZShmbiwgaW5zbiwgYXJnKTsKKwkJfQor
CQlhcmdzW2krK10gPSB2YWx1ZTsKKwkJTkVYVF9QVFJfTElTVChhcmd0eXBlKTsKIAl9IEVORF9G
T1JfRUFDSF9QVFIoYXJnKTsKKwlGSU5JU0hfUFRSX0xJU1QoYXJndHlwZSk7CiAKIAlmdW5jID0g
cHNldWRvX3RvX3ZhbHVlKGZuLCBpbnNuLCBpbnNuLT5mdW5jKTsKIAl0YXJnZXQgPSBMTFZNQnVp
bGRDYWxsKGZuLT5idWlsZGVyLCBmdW5jLCBhcmdzLCBuX2FyZywgIiIpOwo=
--001a1141976244884f054a25bb07--
