Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C46482E6
	for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2023 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0UyJvLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8756C433C8;
	Wed, 20 Dec 2023 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703114027;
	bh=Daop+O/GI7jHv0krEE/8jTo2D/+nug396w8ckhdJFVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0UyJvLSfdn4RnWSoglHZGVVaM0MYAQIy7tSFsjegN7aZJuUvDI5ne8sC8kLzrmRG
	 L9HdFg94IFBuTAkwhigiAT62NShW5SDV8h9b2gl3aT7x9XNC7AOr/jCMxh2kJaUe/+
	 PKyQweaiBwY6a9BLN2a1YDHZO5YyQ5aKhz9kWOc8Hdg4j78lZIwcpg2sQDKiwM/uni
	 ReIMdxLQr9n9YTrEA4CJc4cfqRwfQFQ+f7iB1Mc7HKb7dYDRYY17tQFwKPCHEooNNC
	 uCJvEdg44vn3W0wvtiTYKyjFxw0v4p8S+Qq6WONsb/9tw7DbxVIbzvAusYEj7X16Px
	 mA7PqFn+65HaA==
Date: Thu, 21 Dec 2023 00:13:38 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: sparse regex error
Message-ID: <uug4xslokvlxr6z24q52z4pt7nrtiimbzunz2gz3kpilk4kxts@7jljsksi6baq>
References: <6f853a6b-9ac3-4bfd-a968-89d43fbcce2a@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f853a6b-9ac3-4bfd-a968-89d43fbcce2a@ramsayjones.plus.com>

On Wed, Dec 20, 2023 at 12:18:11AM +0000, Ramsay Jones wrote:
> Hi Luc,
> 
> Long time no hear! ;)

Hi,

Yes indeed ... 
>   $ git diff
>   diff --git a/validation/restrict-array.c b/validation/restrict-array.c
>   index 04bfdad9..86753b7d 100644
>   --- a/validation/restrict-array.c
>   +++ b/validation/restrict-array.c
>   @@ -29,9 +29,19 @@ typedef unsigned long int size_t;
>    
>    extern int regexec (const regex_t *__restrict __preg,
>                       const char *__restrict __string, size_t __nmatch,
>   -                   regmatch_t __pmatch[__restrict_arr],
>   +                   regmatch_t __pmatch[__restrict_arr __nmatch],
>                       int __eflags);

...    

> which, similarly to git, shows errors not on the declaration of the
> regexec() function, but on each call site (about a dozen in git):
> 
>   $ ./sparse validation/restrict-array.c
>   validation/restrict-array.c:32:56: error: undefined identifier '__nmatch'
>   validation/restrict-array.c:32:56: error: bad constant expression type

Yes, it's because __nmatch should be in the function's prototype scope but
Sparse hasn't such a thing.

The following patch is a bit ugly but should solve the problem here above.
It's hasn't had much testing, only the testsuite.

Cheers,
-- Luc


From 2d1feff1551a97fdfd1149f4772331c540e638c9 Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Wed, 20 Dec 2023 22:00:05 +0100
Subject: [PATCH] handle protoype scope

In C99 and later, the size in an array declaration can be either:
a)	D[ ]
b)	D[ * ]
b)	D[ assignment-expression ]
(each optionally preceded by some qualifiers).

Parsing them correctly when the size is present and not an integer
constant expression requires to have the notion of function prototype scope.

Sparse doesn't have yet such a scope which results in pair of error messages like:
	error: undefined identifier
	error: bad constant expression type

Fix this by adding the notion of prototype scope in the form of a block scope
opened and then closed when parsing the parameter list.

Note:
   It's a bit ugly because it is not known if a function declaration
   is a prototype or the start of a function definition before the function
   body is encountered.
---
 parse.c                      |  8 ++++
 validation/prototype-scope.c | 31 +++++++++++++++
 validation/specifiers2.c     | 73 ++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 validation/prototype-scope.c

diff --git a/parse.c b/parse.c
index f868bf63a0f5..b24193e2ee65 100644
--- a/parse.c
+++ b/parse.c
@@ -2593,6 +2593,7 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 {
 	struct symbol_list **list = &fn->arguments;
 
+	start_block_scope();
 	for (;;) {
 		struct symbol *sym;
 
@@ -2611,10 +2612,15 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 			warning(token->pos, "void parameter");
 		}
 		add_symbol(list, sym);
+		// do not bind if there is no ident:
+		// it's ok for declarations, it'll be warned when parsing the body
+		if (sym->ident)
+			bind_symbol(sym, sym->ident, NS_SYMBOL);
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
 	}
+	end_block_scope();
 	return token;
 }
 
@@ -2762,6 +2768,8 @@ static void declare_argument(struct symbol *sym, struct symbol *fn)
 				show_ident(sym->ident));
 		}
 	}
+	// They were previously in the prototype scope.
+	sym->bound = 0;
 	bind_symbol(sym, sym->ident, NS_SYMBOL);
 }
 
diff --git a/validation/prototype-scope.c b/validation/prototype-scope.c
new file mode 100644
index 000000000000..19dbd7265602
--- /dev/null
+++ b/validation/prototype-scope.c
@@ -0,0 +1,31 @@
+struct stuff;
+
+int good(int n, int arr[n]);
+int good(int x, int ptr[x]);
+int good(int n, int arr[n]) { return arr[n - 1]; }
+
+int ugly(int arr[n], int n);
+int  bad(int i, int arr[n]);
+
+int test(int n, int arr[])
+{
+	int a = 0;
+
+	a += good(n, arr);
+	a += ugly(arr, n);
+	a +=  bad(n, arr);
+
+       return a;
+}
+
+/*
+ * check-name: prototype-scope
+ * check-command: sparse -Wno-vla $file
+ *
+ * check-error-start
+prototype-scope.c:7:18: error: undefined identifier 'n'
+prototype-scope.c:7:18: error: bad constant expression type
+prototype-scope.c:8:25: error: undefined identifier 'n'
+prototype-scope.c:8:25: error: bad constant expression type
+ * check-error-end
+ */
diff --git a/validation/specifiers2.c b/validation/specifiers2.c
index d5be118bd2ac..cd848386e2a2 100644
--- a/validation/specifiers2.c
+++ b/validation/specifiers2.c
@@ -75,78 +75,151 @@ void void
 );
 /*
  * check-name: invalid specifier combinations
+ * check-command: sparse -fmax-warnings=unlimited -fmax-errors=unlimited $file
  * check-error-start
 specifiers2.c:3:6: error: two or more data types in declaration specifiers
+specifiers2.c:3:1: error: Trying to use reserved word 'char' as identifier
 specifiers2.c:4:6: error: two or more data types in declaration specifiers
+specifiers2.c:4:1: error: Trying to use reserved word 'int' as identifier
 specifiers2.c:5:6: error: two or more data types in declaration specifiers
+specifiers2.c:5:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:6:6: error: two or more data types in declaration specifiers
+specifiers2.c:6:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:7:6: error: impossible combination of type specifiers: char long
+specifiers2.c:7:1: error: Trying to use reserved word 'long' as identifier
 specifiers2.c:8:6: error: impossible combination of type specifiers: char short
+specifiers2.c:8:1: error: Trying to use reserved word 'short' as identifier
 specifiers2.c:9:5: error: two or more data types in declaration specifiers
+specifiers2.c:9:1: error: Trying to use reserved word 'char' as identifier
 specifiers2.c:10:5: error: two or more data types in declaration specifiers
+specifiers2.c:10:1: error: Trying to use reserved word 'int' as identifier
 specifiers2.c:11:5: error: two or more data types in declaration specifiers
+specifiers2.c:11:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:12:5: error: two or more data types in declaration specifiers
+specifiers2.c:12:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:13:8: error: two or more data types in declaration specifiers
+specifiers2.c:13:1: error: Trying to use reserved word 'char' as identifier
 specifiers2.c:14:8: error: two or more data types in declaration specifiers
+specifiers2.c:14:1: error: Trying to use reserved word 'int' as identifier
 specifiers2.c:15:8: error: two or more data types in declaration specifiers
+specifiers2.c:15:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:16:8: error: two or more data types in declaration specifiers
+specifiers2.c:16:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:17:8: error: impossible combination of type specifiers: double short
+specifiers2.c:17:1: error: Trying to use reserved word 'short' as identifier
 specifiers2.c:18:8: error: impossible combination of type specifiers: double signed
+specifiers2.c:18:1: error: Trying to use reserved word 'signed' as identifier
 specifiers2.c:19:8: error: impossible combination of type specifiers: double unsigned
+specifiers2.c:19:1: error: Trying to use reserved word 'unsigned' as identifier
 specifiers2.c:20:7: error: two or more data types in declaration specifiers
+specifiers2.c:20:1: error: Trying to use reserved word 'char' as identifier
 specifiers2.c:21:7: error: two or more data types in declaration specifiers
+specifiers2.c:21:1: error: Trying to use reserved word 'int' as identifier
 specifiers2.c:22:7: error: two or more data types in declaration specifiers
+specifiers2.c:22:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:23:7: error: two or more data types in declaration specifiers
+specifiers2.c:23:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:24:7: error: impossible combination of type specifiers: float short
+specifiers2.c:24:1: error: Trying to use reserved word 'short' as identifier
 specifiers2.c:25:7: error: impossible combination of type specifiers: float long
+specifiers2.c:25:1: error: Trying to use reserved word 'long' as identifier
 specifiers2.c:26:7: error: impossible combination of type specifiers: float signed
+specifiers2.c:26:1: error: Trying to use reserved word 'signed' as identifier
 specifiers2.c:27:7: error: impossible combination of type specifiers: float unsigned
+specifiers2.c:27:1: error: Trying to use reserved word 'unsigned' as identifier
 specifiers2.c:28:7: error: impossible combination of type specifiers: short char
+specifiers2.c:28:1: error: Trying to use reserved word 'char' as identifier
 specifiers2.c:29:7: error: impossible combination of type specifiers: short double
+specifiers2.c:29:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:30:7: error: impossible combination of type specifiers: short float
+specifiers2.c:30:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:31:7: error: impossible combination of type specifiers: short short
+specifiers2.c:31:1: error: Trying to use reserved word 'short' as identifier
 specifiers2.c:32:7: error: impossible combination of type specifiers: short long
+specifiers2.c:32:1: error: Trying to use reserved word 'long' as identifier
 specifiers2.c:33:6: error: impossible combination of type specifiers: long char
+specifiers2.c:33:1: error: Trying to use reserved word 'char' as identifier
 specifiers2.c:34:6: error: impossible combination of type specifiers: long float
+specifiers2.c:34:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:35:6: error: impossible combination of type specifiers: long short
+specifiers2.c:35:1: error: Trying to use reserved word 'short' as identifier
 specifiers2.c:36:8: error: impossible combination of type specifiers: signed double
+specifiers2.c:36:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:37:8: error: impossible combination of type specifiers: signed float
+specifiers2.c:37:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:38:8: error: impossible combination of type specifiers: signed signed
+specifiers2.c:38:1: error: Trying to use reserved word 'signed' as identifier
 specifiers2.c:39:8: error: impossible combination of type specifiers: signed unsigned
+specifiers2.c:39:1: error: Trying to use reserved word 'unsigned' as identifier
 specifiers2.c:40:10: error: impossible combination of type specifiers: unsigned double
+specifiers2.c:40:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:41:10: error: impossible combination of type specifiers: unsigned float
+specifiers2.c:41:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:42:10: error: impossible combination of type specifiers: unsigned signed
+specifiers2.c:42:1: error: Trying to use reserved word 'signed' as identifier
 specifiers2.c:43:10: error: impossible combination of type specifiers: unsigned unsigned
+specifiers2.c:43:1: error: Trying to use reserved word 'unsigned' as identifier
 specifiers2.c:44:10: error: impossible combination of type specifiers: unsigned signed
+specifiers2.c:44:1: error: Trying to use reserved word 'signed' as identifier
 specifiers2.c:45:11: error: impossible combination of type specifiers: long long long
+specifiers2.c:45:1: error: Trying to use reserved word 'long' as identifier
 specifiers2.c:46:13: error: impossible combination of type specifiers: long long double
+specifiers2.c:46:1: error: Trying to use reserved word 'long' as identifier
 specifiers2.c:47:11: error: impossible combination of type specifiers: long long double
+specifiers2.c:47:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:48:13: error: impossible combination of type specifiers: long long double
+specifiers2.c:48:1: error: Trying to use reserved word 'long' as identifier
 specifiers2.c:49:3: error: two or more data types in declaration specifiers
+specifiers2.c:49:1: error: Trying to use reserved word 'char' as identifier
 specifiers2.c:50:3: error: two or more data types in declaration specifiers
+specifiers2.c:50:1: error: Trying to use reserved word 'int' as identifier
 specifiers2.c:51:3: error: two or more data types in declaration specifiers
+specifiers2.c:51:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:52:3: error: two or more data types in declaration specifiers
+specifiers2.c:52:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:53:3: error: two or more data types in declaration specifiers
+specifiers2.c:53:1: error: Trying to use reserved word 'short' as identifier
 specifiers2.c:54:3: error: two or more data types in declaration specifiers
+specifiers2.c:54:1: error: Trying to use reserved word 'long' as identifier
 specifiers2.c:55:3: error: two or more data types in declaration specifiers
+specifiers2.c:55:1: error: Trying to use reserved word 'signed' as identifier
 specifiers2.c:56:3: error: two or more data types in declaration specifiers
+specifiers2.c:56:1: error: Trying to use reserved word 'unsigned' as identifier
 specifiers2.c:57:3: error: two or more data types in declaration specifiers
+specifiers2.c:57:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:58:6: error: two or more data types in declaration specifiers
+specifiers2.c:58:1: error: Trying to use reserved word 'char' as identifier
 specifiers2.c:59:6: error: two or more data types in declaration specifiers
+specifiers2.c:59:1: error: Trying to use reserved word 'int' as identifier
 specifiers2.c:60:6: error: two or more data types in declaration specifiers
+specifiers2.c:60:1: error: Trying to use reserved word 'double' as identifier
 specifiers2.c:61:6: error: two or more data types in declaration specifiers
+specifiers2.c:61:1: error: Trying to use reserved word 'float' as identifier
 specifiers2.c:62:6: error: two or more data types in declaration specifiers
+specifiers2.c:62:1: error: Trying to use reserved word 'short' as identifier
 specifiers2.c:63:6: error: two or more data types in declaration specifiers
+specifiers2.c:63:1: error: Trying to use reserved word 'long' as identifier
 specifiers2.c:64:6: error: two or more data types in declaration specifiers
+specifiers2.c:64:1: error: Trying to use reserved word 'signed' as identifier
 specifiers2.c:65:6: error: two or more data types in declaration specifiers
+specifiers2.c:65:1: error: Trying to use reserved word 'unsigned' as identifier
 specifiers2.c:66:6: error: two or more data types in declaration specifiers
+specifiers2.c:66:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:67:5: error: two or more data types in declaration specifiers
+specifiers2.c:67:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:68:8: error: two or more data types in declaration specifiers
+specifiers2.c:68:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:69:7: error: two or more data types in declaration specifiers
+specifiers2.c:69:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:70:7: error: impossible combination of type specifiers: short void
+specifiers2.c:70:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:71:6: error: impossible combination of type specifiers: long void
+specifiers2.c:71:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:72:8: error: impossible combination of type specifiers: signed void
+specifiers2.c:72:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:73:10: error: impossible combination of type specifiers: unsigned void
+specifiers2.c:73:1: error: Trying to use reserved word 'void' as identifier
 specifiers2.c:74:6: error: two or more data types in declaration specifiers
+specifiers2.c:74:1: error: Trying to use reserved word 'void' as identifier
  * check-error-end
  */

base-commit: adceff0ab6e3d8bf43de52e2c2fbebf27db30deb
-- 
2.43.0

