From: Christopher Li <sparse@chrisli.org>
Subject: Re: [sparse PATCH RFC] Revert "Revert "sparse: Bump up sizeof(_Bool)
 to 8 bits""
Date: Wed, 16 Jul 2014 14:39:14 -0700
Message-ID: <CANeU7Qkc6LrqM4HiLzirYeKfpnU-d10PyYmYpOr+s2u-K5w_BQ@mail.gmail.com>
References: <1405439200-27515-1-git-send-email-jlayton@primarydata.com>
	<CANeU7QnRHvOQHHE2EEWNSUEwFRv66gmHfNXmgZxN+_J7=iPbHg@mail.gmail.com>
	<20140715222350.028a7bf6@f20.localdomain>
	<CANeU7QngLBOJ-uMV0DFY6sqyi=SbTGJZ6TNZZYnY1jsVsUf12w@mail.gmail.com>
	<20140716122455.33df512f@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:45933 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaGPVjP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Jul 2014 17:39:15 -0400
Received: by mail-qc0-f182.google.com with SMTP id r5so1366970qcx.27
        for <linux-sparse@vger.kernel.org>; Wed, 16 Jul 2014 14:39:14 -0700 (PDT)
In-Reply-To: <20140716122455.33df512f@tlielax.poochiereds.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jeff.layton@primarydata.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>

On Wed, Jul 16, 2014 at 9:24 AM, Jeff Layton
<jeff.layton@primarydata.com> wrote:
>
> Thanks, I think I might have found it. init_ctype tries to correct for
> the fact that bits_to_bytes rounds up instead of down. With the
> corrected function, we don't need that correction anymore.
>
> I'll send the v2 patch soon, which seems to do the right thing.
>

Great catch. I was looking at the it last night but haven't found
the cause. It was not cause by the array element alignment,
which I attach a purposed patch.

I will apply your V2 patch and the fix for the array. Every thing
should be happy now.

Chris

    round up for array element size to byte align

    When layout the array element, the element size should
    round up to byte align.

    Signed-off-by: Christopher Li <sparse@chrisli.org>

diff --git a/evaluate.c b/evaluate.c
index 7ce8c55..03992d0 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2302,7 +2302,7 @@ static struct expression
*check_designators(struct expression *e,
                        }
                        type = ctype->ctype.base_type;
                        if (ctype->bit_size >= 0 && type->bit_size >= 0) {
-                               unsigned offset = e->idx_to * type->bit_size;
+                               unsigned offset =
array_element_offset(type->bit_size, e->idx_to);
                                if (offset >= ctype->bit_size) {
                                        err = "index out of bounds in";
                                        break;
diff --git a/symbol.c b/symbol.c
index 1a3df63..a697627 100644
--- a/symbol.c
+++ b/symbol.c
@@ -234,7 +234,8 @@ static struct symbol * examine_array_type(struct
symbol *sym)
                return sym;

        if (array_size) {
-               bit_size = base_type->bit_size *
get_expression_value_silent(array_size);
+               bit_size = array_element_offset(base_type->bit_size,
+
get_expression_value_silent(array_size));
                if (array_size->type != EXPR_VALUE) {
                        if (Wvla)
                                warning(array_size->pos, "Variable
length array is used.");
diff --git a/target.h b/target.h
index 140df3c..78c85cf 100644
--- a/target.h
+++ b/target.h
@@ -57,4 +57,12 @@ static inline int bytes_to_bits(int bytes)
        return bytes * bits_in_char;
 }

+static inline unsigned long array_element_offset(unsigned long
base_bits, int idx)
+{
+       int fragment = base_bits % bits_in_char;
+       if (fragment)
+               base_bits += bits_in_char - fragment;
+       return base_bits * idx;
+}
+
 #endif
