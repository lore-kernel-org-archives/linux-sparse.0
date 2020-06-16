From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: fix markup in types.rst (s/```/``/)
Date: Tue, 16 Jun 2020 23:04:01 +0200
Message-ID: <20200616210401.77835-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgFPVEG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 Jun 2020 17:04:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55657C061573
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:04:06 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f7so23248951ejq.6
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:04:06 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Literal text was marked with ``` but that's a bit excessive.

Fix that by replacing these with ``.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/types.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/types.rst b/Documentation/types.rst
index 5c10725fa71a..272f32a0f4ed 100644
--- a/Documentation/types.rst
+++ b/Documentation/types.rst
@@ -30,16 +30,16 @@ Some bits, also related to the type, are in struct symbol itself:
   * accessed
   * transparent_union
 
-* ```base_type``` is used for the associated base type.
-* ```modifiers``` is a bit mask for type specifiers (MOD_UNSIGNED, ...),
+* ``base_type`` is used for the associated base type.
+* ``modifiers`` is a bit mask for type specifiers (MOD_UNSIGNED, ...),
   type qualifiers (MOD_CONST, MOD_VOLATILE),
   storage classes (MOD_STATIC, MOD_EXTERN, ...), as well for various
   attributes. It's also used internally to keep track of some states
   (MOD_ACCESS or MOD_ADDRESSABLE).
-* ```alignment``` is used for the alignment, in bytes.
-* ```contexts``` is used to store the informations associated with the
-  attribute ```context()```.
-* ```as``` is used to hold the identifier of the attribute ```address_space()```.
+* ``alignment`` is used for the alignment, in bytes.
+* ``contexts`` is used to store the informations associated with the
+  attribute ``context()``.
+* ``as`` is used to hold the identifier of the attribute ``address_space()``.
 
 Kind of types
 =============
@@ -49,11 +49,11 @@ SYM_BASETYPE
 Used by integer, floating-point, void, 'type', 'incomplete' & bad types.
 
 For integer types:
-  * .ctype.base_type points to ```int_ctype```, the generic/abstract integer type
+  * .ctype.base_type points to ``int_ctype``, the generic/abstract integer type
   * .ctype.modifiers has MOD_UNSIGNED/SIGNED/EXPLICITLY_SIGNED set accordingly.
 
 For floating-point types:
-  * .ctype.base_type points to ```fp_ctype```, the generic/abstract float type
+  * .ctype.base_type points to ``fp_ctype``, the generic/abstract float type
   * .ctype.modifiers is zero.
 
 For the other base types:
@@ -131,7 +131,7 @@ Used for bitwise types (aka 'restricted' types):
 SYM_FOULED
 ----------
 Used for bitwise types when the negation op (~) is
-used and the bit_size is smaller than an ```int```.
+used and the bit_size is smaller than an ``int``.
 There is a 1-to-1 mapping between a fouled type and
 its parent bitwise type.
 
-- 
2.27.0
