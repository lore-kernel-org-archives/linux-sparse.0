From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: [PATCH] Fixup and cleanup of the modifier_string() function (was
 Re: modifier_string() inconsistency with modifiers)
Date: Mon, 23 Aug 2010 16:42:57 +0200
Message-ID: <1282574577.5200.18.camel@thorin>
References: <1282300429.10440.230.camel@thorin>
	 <AANLkTikugbBQ1gYVAdFRxWVmEX-odjq+Y5wA4mnN7Vnj@mail.gmail.com>
	 <1282466539.5200.1.camel@thorin>
	 <AANLkTinT5xhr+C4H71CWx3R9EqHy6ycp8gskjUqjts2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1639 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753080Ab0HWOnF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 23 Aug 2010 10:43:05 -0400
In-Reply-To: <AANLkTinT5xhr+C4H71CWx3R9EqHy6ycp8gskjUqjts2Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Fixup and cleanup of the modifier_string() function

This patch does:
- it fixes the modifier_string() function
- The array with the names is made "static".
- We use C99-indexed initializers. For this we add a set of
  #defines with the bit number.
- replace the open-coded string copy without length check
  with a snprintf()-based one.

Signed-off-by: Bernd Petrovitsch <bernd@sysprog.at>
---
 show-parse.c |   63 +++++++++++++++++++++++-----------
 symbol.h     |  106 +++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 114 insertions(+), 55 deletions(-)

diff --git a/show-parse.c b/show-parse.c
index b771018..34227b4 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -94,31 +94,54 @@ void debug_symbol(struct symbol *sym)
  */
 const char *modifier_string(unsigned long mod)
 {
+	static const char *names[] = {
+		[MOD_AUTO_BIT]			= "auto",
+		[MOD_REGISTER_BIT]		= "register",
+		[MOD_STATIC_BIT]		= "static",
+		[MOD_EXTERN_BIT]		= "extern",
+
+		[MOD_CONST_BIT]			= "const",
+		[MOD_VOLATILE_BIT]		= "volatile",
+		[MOD_SIGNED_BIT]		= "[signed]",
+		[MOD_UNSIGNED_BIT]		= "[unsigned]",
+
+		[MOD_CHAR_BIT]			= "[char]",
+		[MOD_SHORT_BIT]			= "[short]",
+		[MOD_LONG_BIT]			= "[long]",
+		[MOD_LONGLONG_BIT]		= "[long long]",
+
+		[MOD_TYPEDEF_BIT]		= "[typedef]",
+		[MOD_WEAK_BIT]			= "[weak]",
+
+		[MOD_INLINE_BIT]		= "inline",
+		[MOD_ADDRESSABLE_BIT]		= "[addressable]",
+
+		[MOD_NOCAST_BIT]		= "[nocast]",
+		[MOD_NODEREF_BIT]		= "[noderef]",
+		[MOD_ACCESSED_BIT]		= "[accessed]",
+		[MOD_TOPLEVEL_BIT]		= "[toplevel]",
+
+		[MOD_LABEL_BIT]			= "[label]",
+		[MOD_ASSIGNED_BIT]		= "[assigned]",
+		[MOD_TYPE_BIT]			= "[type]",
+		[MOD_SAFE_BIT]			= "[safe]",
+
+		[MOD_USERTYPE_BIT]		= "[usertype]",
+		[MOD_FORCE_BIT]			= "[force]",
+		[MOD_EXPLICITLY_SIGNED_BIT]	= "[explicitly-signed]",
+		[MOD_BITWISE_BIT]		= "[bitwise]",
+        };
 	static char buffer[100];
-	char *p = buffer;
-	const char *res,**ptr, *names[] = {
-		"auto", "register", "static", "extern",
-		"const", "volatile", "[signed]", "[unsigned]",
-		"[char]", "[short]", "[long]", "[long long]",
-		"[typedef]", "[structof]", "[unionof]", "[enum]",
-		"[typeof]", "[attribute]", "inline", "[addressable]",
-		"[nocast]", "[noderef]", "[accessed]", "[toplevel]",
-		"[label]", "[assigned]", "[type]", "[safe]",
-		"[usertype]", "[force]", "[explicitly-signed]",
-		NULL
-	};
-	ptr = names;
-	while ((res = *ptr++) != NULL) {
+	int len = 0;
+        unsigned int i;
+
+	for (i = 0; i < sizeof(names)/sizeof(names[0]) && len < sizeof(buffer); i++) {
 		if (mod & 1) {
-			char c;
-			while ((c = *res++) != '\0')
-				*p++ = c;
-			*p++ = ' ';
+			len += snprintf(buffer+len, sizeof(buffer)-len, " %s", names[i]);
 		}
 		mod >>= 1;
 	}
-	*p = 0;
-	return buffer;
+	return buffer+1; /* hide the first space */
 }
 
 static void show_struct_member(struct symbol *sym)
diff --git a/symbol.h b/symbol.h
index b3fcccd..b66e2a1 100644
--- a/symbol.h
+++ b/symbol.h
@@ -169,41 +169,77 @@ struct symbol {
 };
 
 /* Modifiers */
-#define MOD_AUTO	0x0001
-#define MOD_REGISTER	0x0002
-#define MOD_STATIC	0x0004
-#define MOD_EXTERN	0x0008
-
-#define MOD_CONST	0x0010
-#define MOD_VOLATILE	0x0020
-#define MOD_SIGNED	0x0040
-#define MOD_UNSIGNED	0x0080
-
-#define MOD_CHAR	0x0100
-#define MOD_SHORT	0x0200
-#define MOD_LONG	0x0400
-#define MOD_LONGLONG	0x0800
-
-#define MOD_TYPEDEF	0x1000
-#define MOD_WEAK	0x2000
-
-#define MOD_INLINE	0x40000
-#define MOD_ADDRESSABLE	0x80000
-
-#define MOD_NOCAST	0x100000
-#define MOD_NODEREF	0x200000
-#define MOD_ACCESSED	0x400000
-#define MOD_TOPLEVEL	0x800000	// scoping..
-
-#define MOD_LABEL	0x1000000
-#define MOD_ASSIGNED	0x2000000
-#define MOD_TYPE	0x4000000
-#define MOD_SAFE	0x8000000	// non-null/non-trapping pointer
-
-#define MOD_USERTYPE	0x10000000
-#define MOD_FORCE	0x20000000
-#define MOD_EXPLICITLY_SIGNED	0x40000000
-#define MOD_BITWISE	0x80000000
+#define MOD_AUTO_BIT			 0
+#define MOD_REGISTER_BIT		 1
+#define MOD_STATIC_BIT			 2
+#define MOD_EXTERN_BIT			 3
+
+#define MOD_CONST_BIT			 4
+#define MOD_VOLATILE_BIT		 5
+#define MOD_SIGNED_BIT			 6
+#define MOD_UNSIGNED_BIT		 7
+
+#define MOD_CHAR_BIT			 8
+#define MOD_SHORT_BIT			 9
+#define MOD_LONG_BIT			10
+#define MOD_LONGLONG_BIT		11
+
+#define MOD_TYPEDEF_BIT			12
+#define MOD_WEAK_BIT			13
+#define MOD_INLINE_BIT			14
+#define MOD_ADDRESSABLE_BIT		15
+
+#define MOD_NOCAST_BIT			16
+#define MOD_NODEREF_BIT			17
+#define MOD_ACCESSED_BIT		18
+#define MOD_TOPLEVEL_BIT		19		// scoping..
+
+#define MOD_LABEL_BIT			20
+#define MOD_ASSIGNED_BIT		21
+#define MOD_TYPE_BIT			22
+#define MOD_SAFE_BIT			23		// non-null/non-trapping pointer
+
+#define MOD_USERTYPE_BIT		24
+#define MOD_FORCE_BIT			25
+#define MOD_EXPLICITLY_SIGNED_BIT	26
+#define MOD_BITWISE_BIT			27
+
+/* use the following in the code - we need the above to initialize an array */
+#define MOD_AUTO		(1 << MOD_AUTO_BIT)
+#define MOD_REGISTER		(1 << MOD_REGISTER_BIT)
+#define MOD_STATIC		(1 << MOD_STATIC_BIT)
+#define MOD_EXTERN		(1 << MOD_EXTERN_BIT)
+
+#define MOD_CONST		(1 << MOD_CONST_BIT)
+#define MOD_VOLATILE		(1 << MOD_VOLATILE_BIT)
+#define MOD_SIGNED		(1 << MOD_SIGNED_BIT)
+#define MOD_UNSIGNED		(1 << MOD_UNSIGNED_BIT)
+
+#define MOD_CHAR		(1 << MOD_CHAR_BIT)
+#define MOD_SHORT		(1 << MOD_SHORT_BIT)
+#define MOD_LONG		(1 << MOD_LONG_BIT)
+#define MOD_LONGLONG		(1 << MOD_LONGLONG_BIT)
+
+#define MOD_TYPEDEF		(1 << MOD_TYPEDEF_BIT)
+#define MOD_WEAK		(1 << MOD_WEAK_BIT)
+
+#define MOD_INLINE		(1 << MOD_INLINE_BIT)
+#define MOD_ADDRESSABLE		(1 << MOD_ADDRESSABLE_BIT)
+
+#define MOD_NOCAST		(1 << MOD_NOCAST_BIT)
+#define MOD_NODEREF		(1 << MOD_NODEREF_BIT)
+#define MOD_ACCESSED		(1 << MOD_ACCESSED_BIT)
+#define MOD_TOPLEVEL		(1 << MOD_TOPLEVEL_BIT)
+
+#define MOD_LABEL		(1 << MOD_LABEL_BIT)
+#define MOD_ASSIGNED		(1 << MOD_ASSIGNED_BIT)
+#define MOD_TYPE		(1 << MOD_TYPE_BIT)
+#define MOD_SAFE		(1 << MOD_SAFE_BIT)
+
+#define MOD_USERTYPE		(1 << MOD_USERTYPE_BIT)
+#define MOD_FORCE		(1 << MOD_FORCE_BIT)
+#define MOD_EXPLICITLY_SIGNED	(1 << MOD_EXPLICITLY_SIGNED_BIT)
+#define MOD_BITWISE		(1 << MOD_BITWISE_BIT)
 
 #define MOD_NONLOCAL	(MOD_EXTERN | MOD_TOPLEVEL)
 #define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL | MOD_FORCE | MOD_WEAK)

-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

