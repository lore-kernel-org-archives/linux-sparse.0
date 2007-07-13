From: Rob Taylor <rob.taylor@codethink.co.uk>
Subject: Re: [PATCH] c2xml
Date: Fri, 13 Jul 2007 16:50:35 +0100
Message-ID: <46979F4B.9050307@codethink.co.uk>
References: <46826B68.5040302@codethink.co.uk> <1182970187.8970.145.camel@josh-work.beaverton.ibm.com> <4688F05A.5010801@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208-78-103-131.slicehost.net ([208.78.103.131]:47952 "EHLO
	mail.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758684AbXGMPsq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 11:48:46 -0400
In-Reply-To: <4688F05A.5010801@codethink.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org

Any followups on this?

Thanks,
Rob

Rob Taylor wrote:
> Josh Triplett wrote:
>> On Wed, 2007-06-27 at 14:51 +0100, Rob Taylor wrote:
>>> Here's something I've hacked up for my work on gobject-introspection
>>> [1]. It basically dumps the parse tree for a given file as simplistic
>>> xml, suitable for further transformation by something else (in my case,
>>> some python).
>>>
>>> I'd expect this to also be useful for code navigation in editors and c
>>> refactoring tools, but I've really only focused on my needs for c api
>>> description.
>>>
>>> There are 3 patches here. The first introduces a field in the symbol
>>> struct for the end position of the symbol. I've added this in my case
>>> for documentation generation, but again I think it'd be useful in other
>>> cases. The next introduces a sparse_keep_tokens, which parses a file,
>>> but doesn't free the tokens after parsing. The final one adds c2xml and
>>> the DTD for the xml format. It builds conditionally on whether libxml2
>>> is available.
>>>
>>> All feedback appreciated!
>> Wow.  Very nice.  I can already think of several other uses for this.
> 
> Glad you like it :) OOI, what other uses are you thinking of?
> 
>> A few suggestions:
>>
>>       * Please sign off your patches.  See
>>         http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;hb=HEAD;f=Documentation/SubmittingPatches , section "Sign your work", for details on the Developer's Certificate of Origin and the Signed-off-by convention.  I really need to include some documentation in the Sparse source tree, though.
> 
> Ah, I did wonder what the 'signed-off-by' signified.
> 
>>       * Rather than specifying start="line:col" end="line:col", how
>>         about splitting those up into start-line, start-col, end-line,
>>         and end-col?  That would avoid the need to do string parsing
>>         after reading the XML.
> 
> Yes. I originally had a more human-readable form, and this is a hangover
> from that approach.
> 
>>       * Positions have file information associated with them.  A symbol
>>         might potentially start in one file and end in another, if
>>         people play crazy games with #include.  start-file and end-file?
> 
> Yes, optional end-file would be sensible. Hopefully it wouldn't occur
> very often ;)
> 
>>       * Typo in examine_namespace: "Unregonized namespace".
> yes.
> 
>>       * get_type_name seems generally useful, and several other parts of
>>         Sparse (such as in evaluate.c and show-parse.c) could become
>>         simpler by using it.  How about putting it in symbol.c and
>>         exposing it via symbol.h?  Can you do that in a separate patch,
>>         please?
> 
> Sure.
>>       * Also, should get_type_name perhaps look up the string in an
>>         array rather than using switch?  (I don't know which makes more
>>         sense.)
> 
> Yeah, an array lookup would be better.
> 
>>       * I don't know how much work this would require, but it doesn't
>>         seem like c2xml gets much value out of using libxml, so would it
>>         make things very painful to just print XML directly?  It would
>>         certainly make things like BAD_CAST and having to snprintf to
>>         local buffers go away.  If you count on libxml for some form of
>>         escaping or similar, please ignore this; however, as far as I
>>         can tell, all of the strings that c2xml works with (such as
>>         identifiers) can't have unusual characters in them.
> 
> Well, I'm using the tree builder. It would be non-trivial to rewrite
> without it - see in examine_symbol where I add new nodes to the root
> node and recurse from there.
> 
>>       * Please don't include vim modelines in source files.  (Same goes
>>         for emacs and similar.)
> 
> Sure
> 
>>       * Please explicitly limit the possible values of the type
>>         attribute to those that Sparse produces, rather than allowing
>>         any arbitrary CDATA.  The same goes for a few other 
> 
> Ah, yes, good idea.
> 
> <snip>
> 
>>       * In examine_modifiers, please use C99-style designated assignment
>>         for the modifiers array, for clarity and robustness.
> 
> Hmm, not sure how best to do this. Redefine MOD_* in terms of shifts of
> some linearly assigned constants?
> 
>>       * I suspect several of the modifiers in examine_modifiers don't
>>         need to generate output; I think you want to ignore everything
>>         in MOD_IGNORE.
> 
> Do we really want to not emit any from MOD_STORAGE? I guess if we have
> scoping info at a later date, we can certainly drop MOD_TOPLEVEL, but
> that seems useful ATM. MOD_ADDRESSABLE seems useful. MOD_ASSIGNED,
> MOD_USERTYPE, MOD_FORCE, MOD_ACCESSED and MOD_EXPLICTLY_SIGNED don't
> seem very useful though.
> 
> I think MOD_TYPEDEF would be useful,but I never actually see it. Do you
> know what's going on here?
> 
> 
> Attached you should find the updated patchset with all the changes
> discussed apart from the modifiers stuff discussed above.
> 
> <snip>
> 
>> Note that you don't need to address all of these before resending.  In
>> particular, I'd love to merge the first patch, and I just need a signoff
>> for it.
>>
>> Thanks again for this work; it looks great, and highly useful.
> 
> Thanks to you too!
> 
> Rob Taylor
> 
> 
> 
> ------------------------------------------------------------------------
> 
> From d794c936d62279f37e2e894af3d2297286384dce Mon Sep 17 00:00:00 2001
> From: Rob Taylor <rob.taylor@codethink.co.uk>
> Date: Fri, 29 Jun 2007 17:25:51 +0100
> Subject: [PATCH 1/4] add end position to symbols
> 
> This adds a field in the symbol struct for the position of the end of the
> symbol and code to parse.c to fill this in for the various symbol types when
> parsing.
> 
> Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
> ---
>  parse.c  |   21 ++++++++++++++++++++-
>  symbol.c |    1 +
>  symbol.h |    1 +
>  3 files changed, 22 insertions(+), 1 deletions(-)
> 
> diff --git a/parse.c b/parse.c
> index cb9f87a..ae14642 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -505,6 +505,7 @@ static struct token *struct_union_enum_specifier(enum type type,
>  
>  			// Mark the structure as needing re-examination
>  			sym->examined = 0;
> +			sym->endpos = token->pos;
>  		}
>  		return token;
>  	}
> @@ -519,7 +520,10 @@ static struct token *struct_union_enum_specifier(enum type type,
>  	sym = alloc_symbol(token->pos, type);
>  	token = parse(token->next, sym);
>  	ctype->base_type = sym;
> -	return expect(token, '}', "at end of specifier");
> +	token =  expect(token, '}', "at end of specifier");
> +	sym->endpos = token->pos;
> +
> +	return token;
>  }
>  
>  static struct token *parse_struct_declaration(struct token *token, struct symbol *sym)
> @@ -712,6 +716,9 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
>  			lower_boundary(&lower, &v);
>  		}
>  		token = next;
> +
> +		sym->endpos = token->pos;
> +
>  		if (!match_op(token, ','))
>  			break;
>  		token = token->next;
> @@ -775,6 +782,7 @@ static struct token *typeof_specifier(struct token *token, struct ctype *ctype)
>  		token = parse_expression(token->next, &typeof_sym->initializer);
>  
>  		ctype->modifiers = 0;
> +		typeof_sym->endpos = token->pos;
>  		ctype->base_type = typeof_sym;
>  	}		
>  	return expect(token, ')', "after typeof");
> @@ -1193,12 +1201,14 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
>  			sym = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
>  			token = parameter_type_list(next, sym, p);
>  			token = expect(token, ')', "in function declarator");
> +			sym->endpos = token->pos;
>  			continue;
>  		}
>  		if (token->special == '[') {
>  			struct symbol *array = alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
>  			token = abstract_array_declarator(token->next, array);
>  			token = expect(token, ']', "in abstract_array_declarator");
> +			array->endpos = token->pos;
>  			ctype = &array->ctype;
>  			continue;
>  		}
> @@ -1232,6 +1242,7 @@ static struct token *pointer(struct token *token, struct ctype *ctype)
>  
>  		token = declaration_specifiers(token->next, ctype, 1);
>  		modifiers = ctype->modifiers;
> +		ctype->base_type->endpos = token->pos;
>  	}
>  	return token;
>  }
> @@ -1286,6 +1297,7 @@ static struct token *handle_bitfield(struct token *token, struct symbol *decl)
>  		}
>  	}
>  	bitfield->bit_size = width;
> +	bitfield->endpos = token->pos;
>  	return token;
>  }
>  
> @@ -1306,6 +1318,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
>  		}
>  		apply_modifiers(token->pos, &decl->ctype);
>  		add_symbol(list, decl);
> +		decl->endpos = token->pos;
>  		if (!match_op(token, ','))
>  			break;
>  		token = token->next;
> @@ -1340,6 +1353,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol **
>  	token = declarator(token, sym, &ident);
>  	sym->ident = ident;
>  	apply_modifiers(token->pos, &sym->ctype);
> +	sym->endpos = token->pos;
>  	return token;
>  }
>  
> @@ -1350,6 +1364,7 @@ struct token *typename(struct token *token, struct symbol **p)
>  	token = declaration_specifiers(token, &sym->ctype, 0);
>  	token = declarator(token, sym, NULL);
>  	apply_modifiers(token->pos, &sym->ctype);
> +	sym->endpos = token->pos;
>  	return token;
>  }
>  
> @@ -1818,6 +1833,7 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn,
>  			warning(token->pos, "void parameter");
>  		}
>  		add_symbol(list, sym);
> +		sym->endpos = token->pos;
>  		if (!match_op(token, ','))
>  			break;
>  		token = token->next;
> @@ -2104,6 +2120,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  	token = declarator(token, decl, &ident);
>  	apply_modifiers(token->pos, &decl->ctype);
>  
> +	decl->endpos = token->pos;
> +
>  	/* Just a type declaration? */
>  	if (!ident)
>  		return expect(token, ';', "end of type declaration");
> @@ -2164,6 +2182,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  		token = declaration_specifiers(token, &decl->ctype, 1);
>  		token = declarator(token, decl, &ident);
>  		apply_modifiers(token->pos, &decl->ctype);
> +		decl->endpos = token->pos;
>  		if (!ident) {
>  			sparse_error(token->pos, "expected identifier name in type definition");
>  			return token;
> diff --git a/symbol.c b/symbol.c
> index 329fed9..7585978 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -62,6 +62,7 @@ struct symbol *alloc_symbol(struct position pos, int type)
>  	struct symbol *sym = __alloc_symbol(0);
>  	sym->type = type;
>  	sym->pos = pos;
> +	sym->endpos.type = 0;
>  	return sym;
>  }
>  
> diff --git a/symbol.h b/symbol.h
> index 2bde84d..be5e6b1 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -111,6 +111,7 @@ struct symbol {
>  	enum namespace namespace:9;
>  	unsigned char used:1, attr:2, enum_member:1;
>  	struct position pos;		/* Where this symbol was declared */
> +	struct position endpos;		/* Where this symbol ends*/
>  	struct ident *ident;		/* What identifier this symbol is associated with */
>  	struct symbol *next_id;		/* Next semantic symbol that shares this identifier */
>  	struct symbol **id_list;	/* Back pointer to symbol list head */
> 
> 
> ------------------------------------------------------------------------
> 
> From c0cf0ff431197fe02839ed05cd2e7dd2b6d5cdae Mon Sep 17 00:00:00 2001
> From: Rob Taylor <rob.taylor@codethink.co.uk>
> Date: Fri, 29 Jun 2007 17:33:29 +0100
> Subject: [PATCH 2/4] add sparse_keep_tokens api to lib.h
> 
> Adds sparse_keep_tokens, which is the same as __sparse, but doesn't free the
> tokens after parsing. Useful fow ehen you want to inspect macro symbols after
> parsing.
> 
> Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
> ---
>  lib.c |   13 ++++++++++++-
>  lib.h |    1 +
>  2 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/lib.c b/lib.c
> index 7fea474..aba547a 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -741,7 +741,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
>  	return list;
>  }
>  
> -struct symbol_list * __sparse(char *filename)
> +struct symbol_list * sparse_keep_tokens(char *filename)
>  {
>  	struct symbol_list *res;
>  
> @@ -751,6 +751,17 @@ struct symbol_list * __sparse(char *filename)
>  	new_file_scope();
>  	res = sparse_file(filename);
>  
> +	/* And return it */
> +	return res;
> +}
> +
> +
> +struct symbol_list * __sparse(char *filename)
> +{
> +	struct symbol_list *res;
> +
> +	res = sparse_keep_tokens(filename);
> +
>  	/* Drop the tokens for this file after parsing */
>  	clear_token_alloc();
>  
> diff --git a/lib.h b/lib.h
> index bc2a8c2..aacafea 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -113,6 +113,7 @@ extern void declare_builtin_functions(void);
>  extern void create_builtin_stream(void);
>  extern struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **files);
>  extern struct symbol_list *__sparse(char *filename);
> +extern struct symbol_list *sparse_keep_tokens(char *filename);
>  extern struct symbol_list *sparse(char *filename);
>  
>  static inline int symbol_list_size(struct symbol_list *list)
> 
> 
> ------------------------------------------------------------------------
> 
> From d809173f376d5cb6281832aec57c4f31c0447020 Mon Sep 17 00:00:00 2001
> From: Rob Taylor <rob.taylor@codethink.co.uk>
> Date: Mon, 2 Jul 2007 13:26:42 +0100
> Subject: [PATCH 3/4] new get_type_name function
> 
> Adds function get_type_name to symbol.h to get a string representation of a given type.
> 
> Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
> ---
>  symbol.c |   29 +++++++++++++++++++++++++++++
>  symbol.h |    1 +
>  2 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/symbol.c b/symbol.c
> index 7585978..516c50f 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -444,6 +444,35 @@ struct symbol *examine_symbol_type(struct symbol * sym)
>  	return sym;
>  }
>  
> +const char* get_type_name(enum type type)
> +{
> +	const char *type_lookup[] = {
> +	[SYM_UNINITIALIZED] = "uninitialized",
> +	[SYM_PREPROCESSOR] = "preprocessor",
> +	[SYM_BASETYPE] = "basetype",
> +	[SYM_NODE] = "node",
> +	[SYM_PTR] = "pointer",
> +	[SYM_FN] = "function",
> +	[SYM_ARRAY] = "array",
> +	[SYM_STRUCT] = "struct",
> +	[SYM_UNION] = "union",
> +	[SYM_ENUM] = "enum",
> +	[SYM_TYPEDEF] = "typedef",
> +	[SYM_TYPEOF] = "typeof",
> +	[SYM_MEMBER] = "member",
> +	[SYM_BITFIELD] = "bitfield",
> +	[SYM_LABEL] = "label",
> +	[SYM_RESTRICT] = "restrict",
> +	[SYM_FOULED] = "fouled",
> +	[SYM_KEYWORD] = "keyword",
> +	[SYM_BAD] = "bad"};
> +
> +	if (type <= SYM_BAD)
> +		return type_lookup[type];
> +	else
> +		return NULL;
> +}
> +
>  static struct symbol_list *restr, *fouled;
>  
>  void create_fouled(struct symbol *type)
> diff --git a/symbol.h b/symbol.h
> index be5e6b1..c651a84 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -267,6 +267,7 @@ extern void examine_simple_symbol_type(struct symbol *);
>  extern const char *show_typename(struct symbol *sym);
>  extern const char *builtin_typename(struct symbol *sym);
>  extern const char *builtin_ctypename(struct ctype *ctype);
> +extern const char* get_type_name(enum type type);
>  
>  extern void debug_symbol(struct symbol *);
>  extern void merge_type(struct symbol *sym, struct symbol *base_type);
> 
> 
> ------------------------------------------------------------------------
> 
> From 51785f1c32ab857432f4fb4a5c99bda4d80bc51f Mon Sep 17 00:00:00 2001
> From: Rob Taylor <rob.taylor@codethink.co.uk>
> Date: Mon, 2 Jul 2007 13:27:46 +0100
> Subject: [PATCH 4/4] add c2xml program
> 
> Adds new c2xml program which dumps out the parse tree for a given file as well formed xml. A DTD for the format is included as parse.dtd.
> 
> Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
> ---
>  Makefile  |   15 +++
>  c2xml.c   |  324 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  parse.dtd |   48 +++++++++
>  3 files changed, 387 insertions(+), 0 deletions(-)
>  create mode 100644 c2xml.c
>  create mode 100644 parse.dtd
> 
> diff --git a/Makefile b/Makefile
> index 039fe38..67da31f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -7,6 +7,8 @@ CFLAGS=-O -g -Wall -Wwrite-strings -fpic
>  LDFLAGS=-g
>  AR=ar
>  
> +HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 && echo 'yes')
> +
>  #
>  # For debugging, uncomment the next one
>  #
> @@ -21,8 +23,15 @@ PKGCONFIGDIR=$(LIBDIR)/pkgconfig
>  
>  PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example \
>  	 test-unssa test-dissect ctags
> +
> +
>  INST_PROGRAMS=sparse cgcc
>  
> +ifeq ($(HAVE_LIBXML),yes)
> +PROGRAMS+=c2xml
> +INST_PROGRAMS+=c2xml
> +endif
> +
>  LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
>  	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
>  	  storage.h ptrlist.h dissect.h
> @@ -107,6 +116,12 @@ test-dissect: test-dissect.o $(LIBS)
>  ctags: ctags.o $(LIBS)
>  	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
>  
> +ifeq ($(HAVE_LIBXML),yes)
> +c2xml: c2xml.c $(LIBS) $(LIB_H)
> +	$(CC) $(LDFLAGS) `pkg-config --cflags --libs libxml-2.0` -o $@ $< $(LIBS)
> +
> +endif
> +
>  $(LIB_FILE): $(LIB_OBJS)
>  	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
>  
> diff --git a/c2xml.c b/c2xml.c
> new file mode 100644
> index 0000000..25d1c40
> --- /dev/null
> +++ b/c2xml.c
> @@ -0,0 +1,324 @@
> +/*
> + * Sparse c2xml
> + *
> + * Dumps the parse tree as an xml document
> + *
> + * Copyright (C) 2007 Rob Taylor
> + *
> + * Licensed under the Open Software License version 1.1
> + */
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <assert.h>
> +#include <libxml/parser.h>
> +#include <libxml/tree.h>
> +
> +#include "parse.h"
> +#include "scope.h"
> +#include "symbol.h"
> +
> +xmlDocPtr doc = NULL;       /* document pointer */
> +xmlNodePtr root_node = NULL;/* root node pointer */
> +xmlDtdPtr dtd = NULL;       /* DTD pointer */
> +xmlNsPtr ns = NULL;         /* namespace pointer */
> +int idcount = 0;
> +
> +static struct symbol_list *taglist = NULL;
> +
> +static void examine_symbol(struct symbol *sym, xmlNodePtr node);
> +
> +static xmlAttrPtr newNumProp(xmlNodePtr node, const xmlChar * name, int value)
> +{
> +	char buf[256];
> +	snprintf(buf, 256, "%d", value);
> +	return xmlNewProp(node, name, buf);
> +}
> +
> +static xmlAttrPtr newIdProp(xmlNodePtr node, const xmlChar * name, unsigned int id)
> +{
> +	char buf[256];
> +	snprintf(buf, 256, "_%d", id);
> +	return xmlNewProp(node, name, buf);
> +}
> +
> +static xmlNodePtr new_sym_node(struct symbol *sym, const char *name, xmlNodePtr parent)
> +{
> +	xmlNodePtr node;
> +	const char *ident = show_ident(sym->ident);
> +
> +	assert(name != NULL);
> +	assert(sym != NULL);
> +	assert(parent != NULL);
> +
> +	node = xmlNewChild(parent, NULL, "symbol", NULL);
> +
> +	xmlNewProp(node, "type",  name);
> +
> +	newIdProp(node, "id", idcount);
> +
> +	if (sym->ident && ident)
> +		xmlNewProp(node, "ident", ident);
> +	xmlNewProp(node, "file", stream_name(sym->pos.stream));
> +
> +	newNumProp(node, "start-line", sym->pos.line);
> +	newNumProp(node, "start-col", sym->pos.pos);
> +
> +	if (sym->endpos.type) {
> +		newNumProp(node, "end-line", sym->endpos.line);
> +		newNumProp(node, "end-col", sym->endpos.pos);
> +		if (sym->pos.stream != sym->endpos.stream)
> +			xmlNewProp(node, "end-file", stream_name(sym->endpos.stream));
> +        }
> +	sym->aux = node;
> +
> +	idcount++;
> +
> +	return node;
> +}
> +
> +static inline void examine_members(struct symbol_list *list, xmlNodePtr node)
> +{
> +	struct symbol *sym;
> +	xmlNodePtr child;
> +	char buf[256];
> +
> +	FOR_EACH_PTR(list, sym) {
> +		examine_symbol(sym, node);
> +	} END_FOR_EACH_PTR(sym);
> +}
> +
> +static void examine_modifiers(struct symbol *sym, xmlNodePtr node)
> +{
> +	const char *modifiers[] = {
> +			"auto",
> +			"register",
> +			"static",
> +			"extern",
> +			"const",
> +			"volatile",
> +			"signed",
> +			"unsigned",
> +			"char",
> +			"short",
> +			"long",
> +			"long-long",
> +			"typedef",
> +			NULL,
> +			NULL,
> +			NULL,
> +			NULL,
> +			NULL,
> +			"inline",
> +			"addressable",
> +			"nocast",
> +			"noderef",
> +			"accessed",
> +			"toplevel",
> +			"label",
> +			"assigned",
> +			"type-type",
> +			"safe",
> +			"user-type",
> +			"force",
> +			"explicitly-signed",
> +			"bitwise"};
> +
> +	int i;
> +
> +	if (sym->namespace != NS_SYMBOL)
> +		return;
> +
> +	/*iterate over the 32 bit bitfield*/
> +	for (i=0; i < 32; i++) {
> +		if ((sym->ctype.modifiers & 1<<i) && modifiers[i])
> +			xmlNewProp(node, modifiers[i], "1");
> +	}
> +}
> +
> +static void
> +examine_layout(struct symbol *sym, xmlNodePtr node)
> +{
> +	char buf[256];
> +
> +	examine_symbol_type(sym);
> +
> +	newNumProp(node, "bit-size", sym->bit_size);
> +	newNumProp(node, "alignment", sym->ctype.alignment);
> +	newNumProp(node, "offset", sym->offset);
> +	if (is_bitfield_type(sym)) {
> +		newNumProp(node, "bit-offset", sym->bit_offset);
> +	}
> +}
> +
> +static void examine_symbol(struct symbol *sym, xmlNodePtr node)
> +{
> +	xmlNodePtr child = NULL;
> +	const char *base;
> +	int array_size;
> +	char buf[256];
> +
> +	if (!sym)
> +		return;
> +	if (sym->aux)		/*already visited */
> +		return;
> +
> +	if (sym->ident && sym->ident->reserved)
> +		return;
> +
> +	child = new_sym_node(sym, get_type_name(sym->type), node);
> +	examine_modifiers(sym, child);
> +	examine_layout(sym, child);
> +
> +	if (sym->ctype.base_type) {
> +		if ((base = builtin_typename(sym->ctype.base_type)) == NULL) {
> +			if (!sym->ctype.base_type->aux) {
> +				examine_symbol(sym->ctype.base_type, root_node);
> +			}
> +			xmlNewProp(child, "base-type", 
> +				xmlGetProp((xmlNodePtr)sym->ctype.base_type->aux, "id"));
> +		} else {
> +			xmlNewProp(child, "base-type-builtin", base);
> +		}
> +	}
> +	if (sym->array_size) {
> +		/* TODO: modify get_expression_value to give error return */
> +		array_size = get_expression_value(sym->array_size);
> +		newNumProp(child, "array-size", array_size);
> +	}
> +
> +
> +	switch (sym->type) {
> +	case SYM_STRUCT:
> +	case SYM_UNION:
> +		examine_members(sym->symbol_list, child);
> +		break;
> +	case SYM_FN:
> +		examine_members(sym->arguments, child);
> +		break;
> +	case SYM_UNINITIALIZED:
> +		xmlNewProp(child, "base-type-builtin", builtin_typename(sym));
> +		break;
> +	}
> +	return;
> +}
> +
> +static struct position *get_expansion_end (struct token *token)
> +{
> +	struct token *p1, *p2;
> +
> +	for (p1=NULL, p2=NULL;
> +	     !eof_token(token);
> +	     p2 = p1, p1 = token, token = token->next);
> +
> +	if (p2)
> +		return &(p2->pos);
> +	else
> +		return NULL;
> +}
> +
> +static void examine_macro(struct symbol *sym, xmlNodePtr node)
> +{
> +	xmlNodePtr child;
> +	struct position *pos;
> +	char buf[256];
> +
> +	/* this should probably go in the main codebase*/
> +	pos = get_expansion_end(sym->expansion);
> +	if (pos)
> +		sym->endpos = *pos;
> +	else
> +		sym->endpos = sym->pos;
> +
> +	child = new_sym_node(sym, "macro", node);
> +}
> +
> +static void examine_namespace(struct symbol *sym)
> +{
> +	xmlChar *namespace_type = NULL;
> +
> +	if (sym->ident && sym->ident->reserved)
> +		return;
> +
> +	switch(sym->namespace) {
> +	case NS_MACRO:
> +		examine_macro(sym, root_node);
> +		break;
> +	case NS_TYPEDEF:
> +	case NS_STRUCT:
> +	case NS_SYMBOL:
> +		examine_symbol(sym, root_node);
> +		break;
> +	case NS_NONE:
> +	case NS_LABEL:
> +	case NS_ITERATOR:
> +	case NS_UNDEF:
> +	case NS_PREPROCESSOR:
> +	case NS_KEYWORD:
> +		break;
> +	default:
> +		die("Unrecognised namespace type %d",sym->namespace);
> +	}
> +
> +}
> +
> +static int get_stream_id (const char *name)
> +{
> +	int i;
> +	for (i=0; i<input_stream_nr; i++) {
> +		if (strcmp(name, stream_name(i))==0)
> +			return i;
> +	}
> +	return -1;
> +}
> +
> +static inline void examine_symbol_list(const char *file, struct symbol_list *list)
> +{
> +	struct symbol *sym;
> +	int stream_id = get_stream_id (file);
> +
> +	if (!list)
> +		return;
> +	FOR_EACH_PTR(list, sym) {
> +		if (sym->pos.stream == stream_id)
> +			examine_namespace(sym);
> +	} END_FOR_EACH_PTR(sym);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct string_list *filelist = NULL;
> +	struct symbol_list *symlist = NULL;
> +	char *file;
> +
> +	doc = xmlNewDoc("1.0");
> +	root_node = xmlNewNode(NULL, "parse");
> +	xmlDocSetRootElement(doc, root_node);
> +
> +/* - A DTD is probably unnecessary for something like this
> + 
> +	dtd = xmlCreateIntSubset(doc, "parse", "http://www.kernel.org/pub/software/devel/sparse/parse.dtd" NULL, "parse.dtd");
> +
> +	ns = xmlNewNs (root_node, "http://www.kernel.org/pub/software/devel/sparse/parse.dtd", NULL);
> +
> +	xmlSetNs(root_node, ns);
> +*/
> +	symlist = sparse_initialize(argc, argv, &filelist);
> +
> +	FOR_EACH_PTR_NOTAG(filelist, file) {
> +		examine_symbol_list(file, symlist);
> +		sparse_keep_tokens(file);
> +		examine_symbol_list(file, file_scope->symbols);
> +		examine_symbol_list(file, global_scope->symbols);
> +	} END_FOR_EACH_PTR_NOTAG(file);
> +
> +
> +	xmlSaveFormatFileEnc("-", doc, "UTF-8", 1);
> +	xmlFreeDoc(doc);
> +	xmlCleanupParser();
> +
> +	return 0;
> +}
> +
> diff --git a/parse.dtd b/parse.dtd
> new file mode 100644
> index 0000000..0cbd1b4
> --- /dev/null
> +++ b/parse.dtd
> @@ -0,0 +1,48 @@
> +<!ELEMENT parse (symbol+) >
> +
> +<!ELEMENT symbol (symbol*) >
> +
> +<!ATTLIST symbol type (uninitialized|preprocessor|basetype|node|pointer|function|array|struct|union|enum|typedef|typeof|member|bitfield|label|restrict|fouled|keyword|bad) #REQUIRED
> +                 id ID #REQUIRED
> +		 file CDATA #REQUIRED
> +		 start CDATA #REQUIRED
> +		 end CDATA #IMPLIED
> +
> +		 ident CDATA #IMPLIED
> +		 base-type IDREF #IMPLIED
> +		 base-type-builtin (char|signed char|unsigned char|short|signed short|unsigned short|int|signed int|unsigned int|signed long|long|unsigned long|long long|signed long long|unsigned long long|void|bool|string|float|double|long double|incomplete type|abstract int|abstract fp|label type|bad type) #IMPLIED
> +
> +		 array-size CDATA #IMPLIED
> +
> +		 bit-size CDATA #IMPLIED
> +		 alignment CDATA #IMPLIED
> +		 offset CDATA #IMPLIED
> +		 bit-offset CDATA #IMPLIED
> +
> +		 auto (0|1) #IMPLIED
> +		 register (0|1) #IMPLIED
> +		 static (0|1) #IMPLIED
> +		 extern (0|1) #IMPLIED
> +		 const (0|1) #IMPLIED
> +		 volatile (0|1) #IMPLIED
> +		 signed (0|1) #IMPLIED
> +		 unsigned (0|1) #IMPLIED
> +		 char (0|1) #IMPLIED
> +		 short (0|1) #IMPLIED
> +		 long (0|1) #IMPLIED
> +		 long-long (0|1) #IMPLIED
> +		 typedef (0|1) #IMPLIED
> +		 inline (0|1) #IMPLIED
> +		 addressable (0|1) #IMPLIED
> +		 nocast (0|1) #IMPLIED
> +		 noderef (0|1) #IMPLIED
> +		 accessed (0|1) #IMPLIED
> +		 toplevel (0|1) #IMPLIED
> +		 label (0|1) #IMPLIED
> +		 assigned (0|1) #IMPLIED
> +		 type-type (0|1) #IMPLIED
> +		 safe (0|1) #IMPLIED
> +		 usertype (0|1) #IMPLIED
> +		 force (0|1) #IMPLIED
> +		 explicitly-signed (0|1) #IMPLIED
> +		 bitwise (0|1) #IMPLIED >
